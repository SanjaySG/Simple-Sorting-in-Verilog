`timescale 1ns / 1ps

module project1(
	input clk,
	input [3:0] partA,
	input [3:0] partB,
	input partC,
	input partD,	
	output [3:0] partE
);

	wire [3:0] unsorted_num [3:0];
	wire [3:0] sorted_num [3:0];
	wire start_display;
	
	
	//User Defined registers
	
	// Registers i,j,k are used as counters in loops for sorting and displaying
	reg [3:0] i,j,k;
	
	// Temporary register to swap numbers while sorting
	reg [3:0] temp;
	
	// Register array of numbers to save input and sorted numbers within always blocks
	reg [3:0] numbers [3:0];
	
	// Register to store output to send to partE
	reg [3:0] out;
	
	// Register to trigger display 
	reg start;
	
	//input_part
	//input_part ip(clk, partA, partB, partC,
	//unsorted_num[0], unsorted_num[1], unsorted_num[2], unsorted_num[3]);
	
	initial begin
	$display("Inside the initial procedural block") ;
	temp=0;
	start=0;
	end
	
	
	// Always block for obtaining input during each click of button partC
	always @(posedge partC)
	begin
		$display("Inside the input always block") ;
			if(partA==1) begin				// i.e. partA == 4'b0001
				numbers[0] = partB;
			end else if(partA==2) begin	// i.e. partA == 4'b0010
				numbers[1] = partB;			
			end else if(partA==4) begin	// i.e. partA == 4'b0100
				numbers[2] = partB;			
			end else if(partA==8) begin	// i.e. partA == 4'b1000
				numbers[3] = partB;	
			end
			$display("Exiting the input always block") ;
	end
	
	assign unsorted_num[0] = numbers[0];
	assign unsorted_num[1] = numbers[1];
	assign unsorted_num[2] = numbers[2];
	assign unsorted_num[3] = numbers[3];
	
	// sorting_part
	//sorting_part sp(clk, partD, 
	//unsorted_num[0], unsorted_num[1], unsorted_num[2], unsorted_num[3],
	//sorted_num[0], sorted_num[1], sorted_num[2], sorted_num[3], start_display); 
	
	// Always block for sorting the numbers
	always @(posedge partD)
		begin
			$display("Inside the sorting always block") ;
			$display("The unsorted numbers are :%d %d %d %d",unsorted_num[0],unsorted_num[1],unsorted_num[2],unsorted_num[3]) ;
				for(i=0; i<3; i=i+1) begin
					$display("Inside the sorting outer for loop with i =%d",i) ;
					for(j=0; j<(4-i-1); j=j+1) begin
						$display("Inside the sorting inner for loop with j =%d",j) ;
						if(numbers[j]>numbers[j+1]) begin
							temp=numbers[j];
							numbers[j]=numbers[j+1];
							numbers[j+1]=temp;
						end
					end
				end
				$display("The sorted numbers are :%d %d %d %d",numbers[0],numbers[1],numbers[2],numbers[3]) ;
				start=1;
				$display("Exiting the sorting always block") ;
		end	
	
	
	assign sorted_num[0] = numbers[0];
	assign sorted_num[1] = numbers[1];
	assign sorted_num[2] = numbers[2];
	assign sorted_num[3] = numbers[3];
	assign start_display=start;
	
	// output_part
	//output_part op(clk, sorted_num[0], sorted_num[1], sorted_num[2], sorted_num[3], start_display, partE);
	
	
	// Always block for displaying the ouput
	always @(posedge start_display)
	begin
		$display("Inside the output always block") ;
		if(start==1) begin
			for(k=0;k<20;k=k+1) begin
				#400 out=numbers[k%4];
			end
		end
		$display("Exiting the output always block") ;
	end
	assign partE=out;

endmodule


