require 'tk'
require_relative "func.rb"
require_relative "constants.rb"


root = TkRoot.new do 
    title "Sabina Gamidova CS32" 
    geometry "#{WINDOW_WIDTH}x#{WINDOW_HEIGHT}"
    background BACKGROUND_COLOR
    resizable false, false
end


screen_width = root.winfo_screenwidth
screen_height = root.winfo_screenheight


x = screen_width / 3
y = screen_height / 4
root.geometry("+#{x}+#{y}")


label_frame = TkFrame.new(root) do
  pack(side: 'top', fill: 'both', expand: true)
  background BACKGROUND_COLOR
end


center_frame = TkFrame.new(label_frame) do
  background '#FFFFFF'
  padx 10
  pady 10
end

center_frame.lower

center_frame.place(
  'relx' => 0.5,      
  'rely' => 0.5,      
  'anchor' => 'center',  
  'relwidth' => 0.9,   
  'relheight' => 0.5   
)


def default_label_settings(frame)
  label_variable = TkVariable.new
  label_variable.value = ""

  label = TkLabel.new(frame) do
    textvariable label_variable
    font LABELS_FONT
    background '#FFFFFF'
    pack(side: 'top', pady: 10)
  end

  label.bind("Configure") do
    label.place(
      'relx' => 0.5,
      'rely' => 0.5,
      'anchor' => 'center'
    )
  end

  label_variable
end


input_label = default_label_settings(center_frame)


button_frame = TkFrame.new(root) do
  pack(side: 'bottom', fill: 'both', expand: true)
  background BACKGROUND_COLOR
end


if !ARGV.empty? && ARGV[0].length < MAX_INPUT_LENGTH 
    if(ARGV[0].match?(ARABIC_NUMERAL_REGEX))
        input_label.value = ARGV[0]
    else 
        ARGV[0] = ARGV[0].upcase 
        if(ARGV[0].match?(ROMAN_NUMERAL_REGEX))
            input_label.value = ARGV[0]               
        end
    end
end


def valid_input?(input)
  input.match?(ARABIC_NUMERAL_REGEX)
end


def valid_roman_input?(input)
  input.match?(ROMAN_NUMERAL_REGEX)
end


def handle_convertation(input_label, converter)
  if valid_input?(input_label.value)
    if input_label.value.to_i < 4000
      input_label.value = converter.to_roman_numeral(input_label.value)
    else
      show_error_message('Number must be less than 4000')
    end
  elsif valid_roman_input?(input_label.value)
    input_value = converter.from_roman_numeral(input_label.value)
    if input_value < 4000
      input_label.value = input_value.to_s
    else
      show_error_message('Number must be less than 4000')
    end
  end
end


def show_error_message(message)
  Tk.messageBox(type: 'ok', icon: 'error', title: 'Error', message: message)
end


def default_button_settings(frame, text, background, activebackground, row, col, input_label)
  TkButton.new(frame) do
    text text
    command { 
      case text
      when "<--"
        input_label.value = input_label.value[0...-1] unless input_label.value.empty?
      when "="
        converter = RomanNumeralConverter.new
        handle_convertation(input_label, converter)
      when "CLR"
        input_label.value = ""
      else
        input_label.value = input_label.value << text if input_label.value.length < MAX_INPUT_LENGTH
      end
    }
    grid(row: row, column: col, sticky: 'w', padx: 10, pady: 10)
    borderwidth 4
    relief 'raised' 
    background background
    foreground 'black'
    activebackground activebackground
    font BUTTON_FONT
    width 5
    height 2
  end
end


first_decimal_button = default_button_settings(button_frame, "1", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 0, 1, input_label)
second_decimal_button = default_button_settings(button_frame, "2", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 0, 2, input_label)
third_decimal_button = default_button_settings(button_frame, "3", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 0, 3, input_label)
forth_decimal_button = default_button_settings(button_frame, "4", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 1, 1, input_label)
fifth_decimal_button = default_button_settings(button_frame, "5", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 1, 2, input_label)
sixth_decimal_button = default_button_settings(button_frame, "6", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 1, 3, input_label)
seventh_decimal_button = default_button_settings(button_frame, "7", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 2, 1, input_label)
eighth_decimal_button = default_button_settings(button_frame, "8", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 2, 2, input_label)
ninth_decimal_button = default_button_settings(button_frame, "9", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 2, 3, input_label)
tenth_decimal_button = default_button_settings(button_frame, "0", DECIMAL_COLOR, DARK_DECIMAL_COLOR, 3, 2, input_label)


first_roman_button = default_button_settings(button_frame, "I", ROMAN_COLOR, DARK_ROMAN_COLOR, 1, 5, input_label)
fifth_roman_button = default_button_settings(button_frame, "V", ROMAN_COLOR, DARK_ROMAN_COLOR, 1, 6, input_label)
tenth_roman_button = default_button_settings(button_frame, "X", ROMAN_COLOR, DARK_ROMAN_COLOR, 1, 7, input_label)
fifty_roman_button = default_button_settings(button_frame, "L", ROMAN_COLOR, DARK_ROMAN_COLOR, 2, 5, input_label)
hundred_roman_button = default_button_settings(button_frame, "C", ROMAN_COLOR, DARK_ROMAN_COLOR, 2, 6, input_label)
five_hundred_roman_button = default_button_settings(button_frame, "D", ROMAN_COLOR, DARK_ROMAN_COLOR, 2, 7, input_label)
thousand_roman_button = default_button_settings(button_frame, "M", ROMAN_COLOR, DARK_ROMAN_COLOR, 3, 6, input_label)
convert_button = default_button_settings(button_frame, "=", ADDITIONAL_BUTTONS_COLOR, DARK_ADDITIONAL_BUTTONS_COLOR, 0, 7, input_label)
delete_button = default_button_settings(button_frame, "<--", ADDITIONAL_BUTTONS_COLOR, DARK_ADDITIONAL_BUTTONS_COLOR, 0, 5, input_label)
clear_button = default_button_settings(button_frame, "CLR", ADDITIONAL_BUTTONS_COLOR, DARK_ADDITIONAL_BUTTONS_COLOR, 0, 6, input_label)

Tk.mainloop