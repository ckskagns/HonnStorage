import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class Calculator {

	private JFrame frame;
    private String func = "ADD"; 
    private int firstNumber;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Calculator window = new Calculator();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public Calculator() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 478, 602);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		final JLabel answer = new JLabel("0"); //final 변수 선언
		answer.setHorizontalAlignment(SwingConstants.RIGHT);
		answer.setFont(new Font("굴림", Font.PLAIN, 50));
		answer.setBounds(34, 38, 386, 88);
		frame.getContentPane().add(answer);
		
		JButton btn7 = new JButton("7");
		btn7.setBounds(24, 143, 91, 88);
		frame.getContentPane().add(btn7);
		
		JButton btn8 = new JButton("8");
		btn8.setBounds(129, 143, 91, 88);
		frame.getContentPane().add(btn8);
		
		JButton btn9 = new JButton("9");
		btn9.setBounds(234, 143, 91, 88);
		frame.getContentPane().add(btn9);
		

		
		JButton btn4 = new JButton("4");
		btn4.setBounds(24, 254, 91, 88);
		frame.getContentPane().add(btn4);
		
		JButton btn5 = new JButton("5");
		btn5.setBounds(129, 254, 91, 88);
		frame.getContentPane().add(btn5);
		
		JButton btn6 = new JButton("6");
		btn6.setBounds(234, 254, 91, 88);
		frame.getContentPane().add(btn6);
		


		
		JButton btn1 = new JButton("1");
		btn1.setBounds(24, 355, 91, 88);
		frame.getContentPane().add(btn1);
		
		JButton btn2 = new JButton("2");
		btn2.setBounds(129, 354, 91, 88);
		frame.getContentPane().add(btn2);
		
		JButton btn3 = new JButton("3");
		btn3.setBounds(234, 354, 91, 88);
		frame.getContentPane().add(btn3);
		
		


		
		JButton btnClear = new JButton("C");
		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				answer.setText("0");
			}
		});
		btnClear.setBounds(24, 455, 91, 88);
		frame.getContentPane().add(btnClear);
		
		JButton btn0 = new JButton("0");
		
		btn0.setBounds(129, 454, 91, 88);
		frame.getContentPane().add(btn0);
		//사칙연산(+,-,*,/)버튼을 눌렀을때 라벨의 텍스트를 0으로 초기화 한뒤 func변수에 텍스트값을 변경
    	JButton btnplus = new JButton("+");
		btnplus.addActionListener(new ActionListener() {
		public void actionPerformed(ActionEvent e) {
		String curr = answer.getText();
		firstNumber = Integer.parseInt(curr);
		answer.setText("0");
		func = "ADD";
			}
		});		

		JButton btnminus = new JButton("-");
		btnminus.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String curr = answer.getText();
				firstNumber = Integer.parseInt(curr);
				answer.setText("0");
				func = "MINUS";
			}
		});		
		
		
		JButton btnmulti = new JButton("X");
		btnmulti.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String curr = answer.getText();
				firstNumber = Integer.parseInt(curr);
				answer.setText("0");
				func = "MULTI";
			}
		});		
		
		JButton btndiv = new JButton("/");
		btndiv.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String curr = answer.getText();
				firstNumber = Integer.parseInt(curr);
				answer.setText("0");
				func = "DIV";
			}
		});
		
		btnplus.setBounds(339, 143, 91, 88);
		frame.getContentPane().add(btnplus);
		
		btnminus.setBounds(339, 254, 91, 88);
		frame.getContentPane().add(btnminus);
		
		btnmulti.setBounds(339, 354, 91, 88);
		frame.getContentPane().add(btnmulti);		
		
		btndiv.setBounds(339, 454, 91, 88);
		frame.getContentPane().add(btndiv);		
		
		JButton btnenter = new JButton("=");
		btnenter.setFont(new Font("굴림", Font.PLAIN, 30));
		btnenter.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				switch (func) {
				case "ADD" :{
					int currValue = Integer.parseInt(answer.getText());
					answer.setText((firstNumber+currValue)+"");
					break;
				}
				case "MINUS" :{
					int currValue = Integer.parseInt(answer.getText());
					answer.setText((firstNumber-currValue)+"");
					break;
				}
				case "MULTI" :{
					int currValue = Integer.parseInt(answer.getText());
					answer.setText((firstNumber * currValue)+"");
					break;
				}				
				case "DIV" :{
					int currValue = Integer.parseInt(answer.getText());
					answer.setText((firstNumber / currValue)+"");
					break;
				}				
				
				}
			}
		});
		btnenter.setBounds(234, 454, 91, 88);
		frame.getContentPane().add(btnenter);
		


		
		//상솓받은 메소드를 숫자 액션효과에 적용
		btn0.addActionListener(new NumberActionListener(answer,"0"));
		btn1.addActionListener(new NumberActionListener(answer,"1"));
		btn2.addActionListener(new NumberActionListener(answer,"2"));
		btn3.addActionListener(new NumberActionListener(answer,"3"));
		btn4.addActionListener(new NumberActionListener(answer,"4"));
		btn5.addActionListener(new NumberActionListener(answer,"5"));
		btn6.addActionListener(new NumberActionListener(answer,"6"));
		btn7.addActionListener(new NumberActionListener(answer,"7"));
		btn8.addActionListener(new NumberActionListener(answer,"8"));
		btn9.addActionListener(new NumberActionListener(answer,"9"));
		

	}
}
//버튼클릭 했을때 라벨확인후 텍스트를 수정하는  메소드 생성
class NumberActionListener implements ActionListener{

	private JLabel label;
	private String text;
	
	public NumberActionListener(JLabel l, String s) {
		label = l;
		text = s;
	}
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		String curr = label.getText();
		if(curr.equals("0")) {
			label.setText(text);
		}else{
			label.setText(label.getText()+text);
		
	}

}
}
