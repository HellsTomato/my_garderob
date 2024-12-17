import 'dart:ffi';
var headClother = {'Asian hat': 0, 'Academic cap': 0, 'Balaclava': 0, 'Bandana': 0, 'The hood': 0, 'Baseball cap': 0, 'Takes': 0, 'Beanie': 0, 'Bomber': 0, 'Boyarka': 0, 'Bryl': 0, 'Bennett': 0, 'The eight-link': 0, 'The veil': 0, 'Gaucho': 0, 'Yarmulke': 0, 'The jockey': 0, 'Boater': 0, 'Cap': 0, 'Cloche': 0, 'A cowboy hat': 0, 'Headscarf': 0, 'Coppola': 0, 'Kubanka': 0, 'Visor': 0, 'The bowler hat': 0, 'Ski hat': 0, 'Malachai': 0, 'Panama hat': 0, 'Niqab': 0, 'Papakha': 0, 'Wig': 0, 'Garrison cap': 0, 'Handkerchief': 0, 'Bandage': 0, 'Porky pie': 0, 'Weak': 0, 'Snood': 0, 'Sombrero': 0, 'Pill': 0, 'Current': 0, 'Trilby': 0, 'Skullcap': 0, 'Turban': 0, 'Earflaps': 0, 'Fedora': 0, 'Fez': 0, 'Floppy': 0, 'The cap': 0, 'Hijab': 0, 'Homburg': 0, 'Cylinder': 0, 'Hat': 0, 'Shapoklyak': 0, 'Sheila': 0};
var torsoClother = {'Balmacaan': 0, 'Pea jacket': 0, 'Duster': 0, 'Duflecote': 0, 'Sheepskin coat': 0, 'Inverness': 0, 'Cape': 0, 'The cover-up': 0, 'Cocoon': 0, 'Copar': 0, 'Crombie': 0, 'Coat': 0, 'Ulster': 0, 'A coat with a smell': 0, 'Poncho': 0, 'Down jacket': 0, 'Raglan': 0, 'Redingot': 0, 'Swinger': 0, 'Trench Coat': 0, 'Chesterfield': 0, 'Overcoat': 0, 'English Raincoat': 0, 'Hubertus': 0, 'Raincoat': 0, 'Macintosh': 0, 'Anorak': 0, 'Blouson': 0, 'Bomber': 0, 'Windbreaker': 0, 'Leather jacket': 0, 'Cape Jacket': 0, 'A jacket with a smell': 0, 'Norfolk': 0, 'The Park': 0, 'Spencer': 0, 'Tank Top': 0, 'Blouse': 0, 'Blazer': 0, 'Sweater': 0, 'Jacket': 0, 'Cardigan': 0, 'Combidress': 0, 'Overall': 0, 'Pullover': 0, 'Shirt': 0, 'T-shirt': 0, 'Dress': 0, 'Top': 0};
var legsClother = {'Shorts': 0, 'Afghani': 0, 'Buggy': 0, 'Bumsters': 0, 'Bananas': 0, 'Bermuda': 0, 'Boyfriends': 0, 'Breeches': 0, 'Jeans': 0, 'Joggers': 0, 'Pipes': 0, 'Capri': 0, 'Cargo': 0, 'Carrot': 0, 'Classic': 0, 'Flared': 0, 'Leggings': 0, 'Skinny': 0, 'Slacks': 0, 'Chinos': 0, 'Bloomers': 0, 'Culottes': 0, 'The Palazzo': 0, 'Gaucho': 0, 'Churidary': 0, 'Skirt': 0};
var feetClother = {'Ballet shoes': 0, 'Grandmothers': 0, 'Berets': 0, 'Birkenstocks': 0, 'Sandals': 0, 'Ankle Boots': 0, 'Boots': 0, 'Brogues': 0, 'Vibration': 0, 'Winklepickers': 0, 'The Wellingtons': 0, 'Work boots': 0, 'Grinders': 0, 'The Derby': 0, 'Jackpots': 0, 'Jodhpurs': 0, 'Sneakers': 0, 'Crocs': 0, 'Louboutins': 0, 'Boats': 0, 'Loafers': 0, 'Moon rovers': 0, 'Mary Jane': 0, 'Moccasins': 0, 'The Monks': 0, 'Mules': 0, 'Soap dishes': 0, 'Oxfords': 0, 'Pantolets': 0, 'Bullets': 0, 'Readings': 0, 'Clogs': 0, 'Cossack boots': 0, 'Cowboy boots': 0, 'Boots-stockings': 0, 'Sleepers': 0, 'Slip-ons': 0, 'Stilettos': 0, 'Tennis shoes': 0, 'Timberlands': 0, 'Topsiders': 0, 'Tango Shoes': 0, 'Shoes-gloves': 0, 'Ugg boots': 0, 'Hackers': 0, 'Chakka': 0, 'Chelsea': 0, 'Czechs': 0, 'Espadrilles': 0, 'Yacht shoes': 0};


class SafePhoto{
   static var photohead = "";
  static var photoTorso = "";
  static var photoLegs = "";

  static var photoFeet = "";
}


class AddedClother {
  static var head = headClother;
  static var torso = torsoClother;
  static var legs = legsClother;
  static var feet = feetClother;


}

