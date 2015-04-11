`timescale 1ns / 1ps
/*
 * Copyright 2015 Forest Crossman
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

module pwm_demo(
	input CLK_100MHz,
	input [25:10] IO,
	input SW1,
	output [9:3] IO,
	output reg [7:0] LED
	);

	wire [7:0] address;
	wire [7:0] data;
	wire latch;
	assign address = IO[25:18];
	assign data = IO[17:10];
	assign latch = ~SW1;

	reg [7:0] period [0:256-1];

	pwm_generator pwm3(.clk(CLK_100MHz), .period(period[3]), .pin(IO[3]));
	pwm_generator pwm4(.clk(CLK_100MHz), .period(period[4]), .pin(IO[4]));
	pwm_generator pwm5(.clk(CLK_100MHz), .period(period[5]), .pin(IO[5]));
	pwm_generator pwm6(.clk(CLK_100MHz), .period(period[6]), .pin(IO[6]));
	pwm_generator pwm7(.clk(CLK_100MHz), .period(period[7]), .pin(IO[7]));
	pwm_generator pwm8(.clk(CLK_100MHz), .period(period[8]), .pin(IO[8]));
	pwm_generator pwm9(.clk(CLK_100MHz), .period(period[9]), .pin(IO[9]));

	always @(posedge CLK_100MHz) begin
		if (latch) begin
			LED <= address;
			period[address] <= data;
		end
	end
endmodule

module pwm_generator(
	input clk,
	input [7:0] period,
	output pin
	);

	reg [7:0] counter;
	reg pin_out;
	assign pin = pin_out;

	always @(posedge clk) begin
		if (counter < period)
			counter <= counter + 1;
		else begin
			counter <= 0;
			case (pin)
				1'b0: pin_out <= 1;
				1'b1: pin_out <= 0;
				default: pin_out <= 0;
			endcase
		end
	end
endmodule
