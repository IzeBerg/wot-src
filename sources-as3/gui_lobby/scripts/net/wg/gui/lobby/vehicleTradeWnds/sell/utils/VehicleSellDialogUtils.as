package net.wg.gui.lobby.vehicleTradeWnds.sell.utils
{
   import net.wg.data.constants.Currencies;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   
   public class VehicleSellDialogUtils
   {
      
      public static const EXTRA_CURRENCY_COLOR:uint = 15327935;
      
      public static const DEMOUNT_KIT:String = "demountKit";
      
      public static const EMPTY_STR:String = "";
      
      public static const PLUS_STR:String = "+";
      
      private static var _iconsByCurrency:Object = null;
       
      
      public function VehicleSellDialogUtils()
      {
         super();
      }
      
      private static function getIconByCurrency(param1:String) : String
      {
         if(_iconsByCurrency == null)
         {
            _iconsByCurrency = {};
            _iconsByCurrency[CURRENCIES_CONSTANTS.CREDITS] = RES_ICONS.MAPS_ICONS_LIBRARY_CREDITSICON_2;
            _iconsByCurrency[CURRENCIES_CONSTANTS.GOLD] = RES_ICONS.MAPS_ICONS_LIBRARY_GOLDICON_2;
            _iconsByCurrency[CURRENCIES_CONSTANTS.CRYSTAL] = RES_ICONS.MAPS_ICONS_LIBRARY_CRYSTAL_16X16;
            _iconsByCurrency[CURRENCIES_CONSTANTS.EQUIP_COIN] = RES_ICONS.MAPS_ICONS_LIBRARY_EQUIPCOIN_1;
            _iconsByCurrency[DEMOUNT_KIT] = RES_ICONS.MAPS_ICONS_DEMOUNTKIT_COMMON_16X16;
         }
         if(_iconsByCurrency.hasOwnProperty(param1))
         {
            return _iconsByCurrency[param1];
         }
         return RES_ICONS.MAPS_ICONS_LIBRARY_CREDITSICON_2;
      }
      
      public static function getCost(param1:Number, param2:String) : String
      {
         if(param2 == CURRENCIES_CONSTANTS.CREDITS)
         {
            return (param1 > 0 ? PLUS_STR : EMPTY_STR) + App.utils.locale.integer(param1);
         }
         return (param1 > 0 ? PLUS_STR : EMPTY_STR) + App.utils.locale.gold(param1);
      }
      
      public static function isMoney(param1:String) : Boolean
      {
         return Currencies.INDEX_FROM_NAME.indexOf(param1) != -1;
      }
      
      public static function extractSortedCurrencies(param1:Object) : Vector.<String>
      {
         var _loc2_:* = null;
         var _loc3_:Vector.<String> = new Vector.<String>(0);
         var _loc4_:Array = Currencies.NAME_FROM_INDEX;
         for each(_loc2_ in _loc4_)
         {
            if(int(param1[_loc2_]) != 0)
            {
               _loc3_.unshift(_loc2_);
            }
         }
         for(_loc2_ in param1)
         {
            if(_loc4_.indexOf(_loc2_) == -1 && int(param1[_loc2_]) != 0)
            {
               _loc3_.unshift(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public static function getColorByCurrency(param1:String) : uint
      {
         if(Currencies.TEXT_COLORS.hasOwnProperty(param1))
         {
            return Currencies.TEXT_COLORS[param1];
         }
         return EXTRA_CURRENCY_COLOR;
      }
      
      public static function getLabel(param1:String, param2:String = null) : String
      {
         var _loc3_:String = getIconByCurrency(param2);
         _loc3_ = _loc3_.replace("..","img://gui");
         return "<img src=\"" + _loc3_ + "\" width=\"16\" height=\"16\" vspace=\"-4\" hspace=\"0\"/>&nbsp;" + App.utils.locale.makeString(param1);
      }
   }
}
