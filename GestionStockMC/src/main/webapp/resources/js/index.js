

var d_names = new Array("Dim", "Lun", "Mar",
"Mer", "Jeu", "Ven", "Sam");

var m_names = new Array("Jan", "Fév", "Mar", 
"Avr", "Mai", "Jui", "Juil", "Aout", "Sept", 
"Oct", "Nov", "Déc");

var d = new Date();
var curr_day = d.getDay();
var curr_date = d.getDate();

var curr_month = d.getMonth();
var curr_year = d.getFullYear();

jQuery('#dateH').html(d_names[curr_day] + " " + "," + curr_date +" "+ m_names[curr_month]);


