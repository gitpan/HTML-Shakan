use strict;
use warnings;
use HTML::Shakan;
use t::Util;
use Test::More;

my $form = HTML::Shakan->new(
    request => query({}),
    fields => [ ],
);
is $form->widgets->render( $form, EmailField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="text" />';
is $form->widgets->render( $form, TextField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="text" />';
is $form->widgets->render( $form, UIntField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="text" />';
is $form->widgets->render( $form, IntField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="text" />';
is $form->widgets->render( $form, URLField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="text" />';
is $form->widgets->render( $form, PasswordField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="password" />';
is $form->widgets->render( $form, FileField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="file" />';
is $form->widgets->render( $form, ImageField( name => 'foo', id => 'name_field' ) ), '<input id="name_field" name="foo" type="file" />';
is $form->widgets->render( $form, TextField( name => 'foo', id => 'name_field', widget => 'textarea' ) ), '<textarea id="name_field" name="foo"></textarea>';

# choices-field + select-widgets
is $form->widgets->render( $form, ChoiceField( name => 'foo', id => 'name_field', choices => [] ) ), qq{<select id="name_field" name="foo">\n</select>};
is $form->widgets->render( $form, ChoiceField( name => 'foo', id => 'name_field', choices => ['a' => 1, 'b' => 2, 'c' => 3] ) ), trim(<<'...');
<select id="name_field" name="foo">
<option value="a">1</option>
<option value="b">2</option>
<option value="c">3</option>
</select>
...

# choices-field + radio-widgets
is $form->widgets->render( $form, ChoiceField( widget => 'radio', name => 'foo', id => 'name_field', choices => ['a' => 1, 'b' => 2, 'c' => 3] ) ), trim(<<'...');
<ul>
<li><label><input id="id_foo_0" name="foo" type="radio" value="a" />1</label></li>
<li><label><input id="id_foo_1" name="foo" type="radio" value="b" />2</label></li>
<li><label><input id="id_foo_2" name="foo" type="radio" value="c" />3</label></li>
</ul>
...

# choices-field + checkbox-widgets
is $form->widgets->render( $form, ChoiceField( widget => 'checkbox', name => 'bar', id => 'name_field', choices => ['a' => 1, 'b' => 2, 'c' => 3] ) ), trim(<<'...');
<ul>
<li><label><input id="id_bar_0" name="bar" type="checkbox" value="a" />1</label></li>
<li><label><input id="id_bar_1" name="bar" type="checkbox" value="b" />2</label></li>
<li><label><input id="id_bar_2" name="bar" type="checkbox" value="c" />3</label></li>
</ul>
...

# date field
is $form->widgets->render( $form, DateField( name => 'birthdate', years => [2000..2003] ) ), trim(<<'...');
<span>
<select name="birthdate_year">
<option value="2000">2000</option>
<option value="2001">2001</option>
<option value="2002">2002</option>
<option value="2003">2003</option>
</select>
<select name="birthdate_month">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
</select>
<select name="birthdate_day">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
<option value="26">26</option>
<option value="27">27</option>
<option value="28">28</option>
<option value="29">29</option>
<option value="30">30</option>
<option value="31">31</option>
</select>
</span>
...

# choices-field + select-widgets + zero value
my $q_choice = query;
$q_choice->param(foo => 0);
my $form_choice = HTML::Shakan->new(
    request => $q_choice,
    fields => [ ],
);
is $form_choice->widgets->render( $form_choice, ChoiceField( name => 'foo', id => 'name_field', choices => ['0' => 'zero', '1' => 'a', '2' => 'b', '3' => 'c'] ) ), trim(<<'...');
<select id="name_field" name="foo">
<option value="0" selected="selected">zero</option>
<option value="1">a</option>
<option value="2">b</option>
<option value="3">c</option>
</select>
...

# choices-field + radio-widgets + zero value
my $q_radio = query;
$q_radio->param(foo => 0);
my $form_radio = HTML::Shakan->new(
    request => $q_radio,
    fields => [ ],
);
is $form_radio->widgets->render( $form_radio, ChoiceField( widget => 'radio', name => 'foo', id => 'name_field', choices => ['0' => 'zero', '1' => 'a', '2' => 'b', '3' => 'c'] ) ), trim(<<'...');
<ul>
<li><label><input id="id_foo_0" name="foo" type="radio" value="0" checked="checked" />zero</label></li>
<li><label><input id="id_foo_1" name="foo" type="radio" value="1" />a</label></li>
<li><label><input id="id_foo_2" name="foo" type="radio" value="2" />b</label></li>
<li><label><input id="id_foo_3" name="foo" type="radio" value="3" />c</label></li>
</ul>
...

subtest 'widget_input' => sub {
    my $form_with_value = HTML::Shakan->new(
        request => query({
            foo_1 => 'foo_1',
            foo_2 => '0',
            foo_3 => 0,
        }),
        fields => [ ],
    );
    is $form->widgets->widget_input($form_with_value, TextField( name => 'foo_1', id => 'name_field' )),
          '<input id="name_field" name="foo_1" type="text" value="foo_1" />';
    is $form->widgets->widget_input($form_with_value, TextField( name => 'foo_2', id => 'name_field' )),
          '<input id="name_field" name="foo_2" type="text" value="0" />';
    is $form->widgets->widget_input($form_with_value, TextField( name => 'foo_3', id => 'name_field' )),
          '<input id="name_field" name="foo_3" type="text" value="0" />';
};

done_testing;
