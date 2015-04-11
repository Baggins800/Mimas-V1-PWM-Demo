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
	input [2:0] ADDRESS,
	input [7:0] DATA,
	input SW1,
	output [7:0] PWM,
	output reg [7:0] LED
	);

	wire [2:0] address;
	wire [7:0] data;
	wire latch;
	assign address = ADDRESS;
	assign data = DATA;
	assign latch = ~SW1;

	reg [7:0] period [0:256-1];

	pwm_generator pwm0(.clk(CLK_100MHz), .period(period[0]), .pin(PWM[0]));
	pwm_generator pwm1(.clk(CLK_100MHz), .period(period[1]), .pin(PWM[1]));
	pwm_generator pwm2(.clk(CLK_100MHz), .period(period[2]), .pin(PWM[2]));
	pwm_generator pwm3(.clk(CLK_100MHz), .period(period[3]), .pin(PWM[3]));
	pwm_generator pwm4(.clk(CLK_100MHz), .period(period[4]), .pin(PWM[4]));
	pwm_generator pwm5(.clk(CLK_100MHz), .period(period[5]), .pin(PWM[5]));
	pwm_generator pwm6(.clk(CLK_100MHz), .period(period[6]), .pin(PWM[6]));
	pwm_generator pwm7(.clk(CLK_100MHz), .period(period[7]), .pin(PWM[7]));

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
