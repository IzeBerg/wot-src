package net.wg.data.constants
{
   import net.wg.data.constants.generated.ICON_TEXT_FRAMES;
   
   public class IconsTypes
   {
      
      public static const EMPTY:String = ICON_TEXT_FRAMES.EMPTY;
      
      public static const CREDITS:String = ICON_TEXT_FRAMES.CREDITS;
      
      public static const GOLD:String = ICON_TEXT_FRAMES.GOLD;
      
      public static const CREDITS_BIG:String = ICON_TEXT_FRAMES.CREDITS_BIG;
      
      public static const GOLD_BIG:String = ICON_TEXT_FRAMES.GOLD_BIG;
      
      public static const GOLD_DISCOUNT:String = ICON_TEXT_FRAMES.GOLD_DISCOUNT;
      
      public static const XP:String = ICON_TEXT_FRAMES.XP;
      
      public static const ELITE_XP:String = ICON_TEXT_FRAMES.ELITE_XP;
      
      public static const ELITE:String = ICON_TEXT_FRAMES.ELITE;
      
      public static const ARROW_DOWN:String = ICON_TEXT_FRAMES.ARROW_DOWN;
      
      public static const ARROW_UP:String = ICON_TEXT_FRAMES.ARROW_UP;
      
      public static const ARROW_DOWN_DISABLED:String = ICON_TEXT_FRAMES.ARROW_DOWN_DISABLED;
      
      public static const ELITE_TANK_XP:String = ICON_TEXT_FRAMES.ELITE_TANK_XP;
      
      public static const FREE_XP:String = ICON_TEXT_FRAMES.FREE_XP;
      
      public static const CRYSTAL:String = ICON_TEXT_FRAMES.CRYSTAL;
      
      public static const EQUIP_COIN:String = ICON_TEXT_FRAMES.EQUIP_COIN;
      
      public static const EQUIP_COIN_BIG:String = ICON_TEXT_FRAMES.EQUIP_COIN_BIG;
      
      public static const TANK_DAILYXPFACTOR:String = ICON_TEXT_FRAMES.TANK_DAILYXPFACTOR;
      
      public static const TANK_UNLOCK_PRICE:String = ICON_TEXT_FRAMES.TANK_UNLOCK_PRICE;
      
      public static const DOUBLE_XP_FACTOR:String = ICON_TEXT_FRAMES.DOUBLE_XP_FACTOR;
      
      public static const ACTION_XP_FACTOR:String = ICON_TEXT_FRAMES.ACTION_XP_FACTOR;
      
      public static const CLASS1:String = ICON_TEXT_FRAMES.CLASS1;
      
      public static const CLASS2:String = ICON_TEXT_FRAMES.CLASS2;
      
      public static const CLASS3:String = ICON_TEXT_FRAMES.CLASS3;
      
      public static const CLASS4:String = ICON_TEXT_FRAMES.CLASS4;
      
      public static const XP_PRICE:String = ICON_TEXT_FRAMES.XP_PRICE;
      
      public static const DEFRES:String = ICON_TEXT_FRAMES.DEFRES;
      
      public static const RENTALS:String = ICON_TEXT_FRAMES.RENTALS;
      
      public static const REWARD_SHEET:String = ICON_TEXT_FRAMES.REWARD_SHEET;
      
      public static const CREDITS_COLOR:int = 13556185;
      
      public static const GOLD_COLOR:int = 16761699;
      
      public static const XP_COLOR:int = 13224374;
      
      public static const CRYSTAL_COLOR:int = 13224374;
      
      public static const EQUIP_COIN_COLOR:int = 13224374;
      
      public static const ALLOW_ICONS:Array = [EMPTY,CREDITS,GOLD,GOLD_DISCOUNT,XP,ELITE_XP,ELITE,ARROW_DOWN,ARROW_UP,ARROW_DOWN_DISABLED,ELITE_TANK_XP,FREE_XP,TANK_DAILYXPFACTOR,TANK_UNLOCK_PRICE,DOUBLE_XP_FACTOR,ACTION_XP_FACTOR,CLASS1,CLASS2,CLASS3,CLASS4,XP_PRICE,DEFRES,RENTALS,REWARD_SHEET,CRYSTAL,EQUIP_COIN];
       
      
      public function IconsTypes()
      {
         super();
      }
      
      public static function getTextColor(param1:String) : Number
      {
         var _loc2_:Number = -1;
         switch(param1)
         {
            case CREDITS_BIG:
            case CREDITS:
               _loc2_ = CREDITS_COLOR;
               break;
            case GOLD_BIG:
            case GOLD:
               _loc2_ = GOLD_COLOR;
               break;
            case FREE_XP:
               _loc2_ = XP_COLOR;
               break;
            case CRYSTAL:
               _loc2_ = CRYSTAL_COLOR;
               break;
            case EQUIP_COIN:
            case EQUIP_COIN_BIG:
               _loc2_ = EQUIP_COIN_COLOR;
         }
         return _loc2_;
      }
      
      public static function getCurrencyIcon(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case CREDITS:
               _loc3_ = !!param2 ? CREDITS_BIG : CREDITS;
               break;
            case GOLD:
               _loc3_ = !!param2 ? GOLD_BIG : GOLD;
               break;
            default:
               _loc3_ = param1;
         }
         return _loc3_;
      }
      
      public static function getCurrencyName(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case CREDITS:
            case CREDITS_BIG:
               _loc2_ = CREDITS;
               break;
            case GOLD:
            case GOLD_BIG:
               _loc2_ = GOLD;
               break;
            default:
               _loc2_ = param1;
         }
         return _loc2_;
      }
   }
}
