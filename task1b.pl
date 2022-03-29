use DBI;
use strict;

my $dbh = DBI->connect ('DBI:mysql:u1591605_db:37.140.192.18','u1591605_user','rQ7eI9sG6lxT3q') 
    or die "Can’t connect to DB\nError: $DBI::errstr\nExiting";

sub make_sql_query {
    my $query = shift;

    my $sth = $dbh->prepare($query) or die "prepare statement failed $DBI::errstr";
    $sth->execute() or die "execution failed: $DBI::errstr"; 		

    return $sth;
}

for(;;) {
    print "\n";
    print "\t Замечательная телефонная книжка\n";
    print "\n";
    print "Показать все контакты      1\n";
    print "Добавить контакт           2\n";
    print "Удалить контакт            3\n";
    print "Изменить контакт           4\n";
    print "Выйти                      5\n";

    my $input;
    my $flag = 1;

    while ( $flag ) {
        $input = <STDIN>;
        if ($input =~ /^[1-5]$/) {
            $flag = 0;
        }
        else {
            print "Выберите опцию от 1 до 5 => ";
        }
    }

    if ( $input ) {

        if ( $input == 1 ) {
            print "\t Все контакты\n";
            
            my $sth = make_sql_query("SELECT id, full_name, phone_number FROM phonebook");
            my($id,$full_name,$phone_number);

            while ( ($id, $full_name, $phone_number) = $sth->fetchrow() ) {
                print "$id $full_name $phone_number\n";
            }
            $sth->finish();
        }

        if ( $input == 2 ) {
            print "\t Добавить контакт\n";
            print "Имя и Фамилия  => ";
            my $full_name;
            my $flag = 1;

            while ( $flag ) {
                $full_name = <STDIN>;
                chomp($full_name);
                if ( $full_name =~ /^[A-Z][a-z]+\s[A-Z][a-z]+$/ ) {
                    $flag = 0;
                }
                else {
                    print "Имя и Фамилия с заглавной буквы на латинице\n";
                    print "Имя и Фамилия  => ";
                }
            }
            print "Номер телефона => ";
            my $phone;
            $flag = 1;

            while ( $flag ) {
                $phone = <STDIN>;
                if ( $phone =~ /^[+0-9]{8,12}$/ ) {
                    $flag = 0;
                }
                else {
                    print "Телефон должен состоять от 8 до 12 цифр\n";
                    print "Номер телефона => ";
                }
            }

            my $sth = make_sql_query("INSERT INTO phonebook (full_name, phone_number) VALUES('$full_name',$phone)");
            $sth->finish();

            print "Контакт успешно добавлен!\n";
        }

        if ( $input == 3 ) {
            print "\t Удалить контакт\n";
            print "Удалить запись с id => ";
            my $delete_id;
            my $flag = 1;

            while ( $flag ) {
                $delete_id = <STDIN>;
                if ( $delete_id =~ /\d*$/ ) {
                   $flag = 0;
                }
                else {
                    print "id состоит только из цифр\n";
                    print "Удалить запись с id => ";
                }
            }

            my $sth = make_sql_query("DELETE FROM phonebook WHERE id='$delete_id'");
            $sth->finish();

            print "Контакт успешно удален!\n";
        }

        if ( $input == 4 ) {
            print "\t Изменить контакт\n";
            print "Укажите id записи => ";
            my $update_id;
            my $flag=1;

            while ( $flag ) {
                $update_id = <STDIN>;
                if ( $update_id =~ /\d*$/ ) {
                    $flag = 0;
                }
                else {
                    print "id состоит только из цифр\n";
                    print "Укажите id записи => ";
                }
            }
            print "Новый номер телефона => ";
            my $new_phone;
            $flag = 1;

            while ( $flag ) {
                $new_phone = <STDIN>;
                if ( $new_phone =~ /^[+0-9]{8,12}$/ ) {
                    $flag = 0;
                }
                else {
                    print "Телефон должен состоять от 8 до 12 цифр\n";
                    print "Новый номер телефона => ";
                }
            }

            my $sth = make_sql_query("UPDATE phonebook SET phone_number=$new_phone WHERE id=$update_id");
            $sth->finish();

            print "Номер успешно изменен!\n";
        }

        if ( $input == 5 ) {
            print "\t До новых встреч!\n";
            last;
        }
    }
}
$dbh->disconnect; 
exit 0;