package net.wg.gui.battle.battleloading.util
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class BattleLoadingUtil
   {
      
      private static const IMG_TAG_CLOSE:String = "\"/>";
      
      private static const IMG_TAG_OPEN_BASIC:String = "<IMG SRC=\"img://gui/maps/icons/library/basic_small.png\" width=\"26\" height=\"16\" vspace=\"";
      
      private static const IMG_TAG_OPEN_PREMIUM:String = "<IMG SRC=\"img://gui/maps/icons/library/premium_small.png\" width=\"34\" height=\"16\" vspace=\"";
      
      private static const CLAN_TAG_OPEN:String = "[";
      
      private static const CLAN_TAG_CLOSE:String = "]";
      
      private static const CUT_SYMBOLS_STR:String = "..";
      
      private static const TEXT_FIELD_BOUNDS_WIDTH:Number = 4;
       
      
      public function BattleLoadingUtil()
      {
         super();
      }
      
      public static function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean
      {
         var _loc10_:Boolean = false;
         var _loc12_:Rectangle = null;
         var _loc13_:Rectangle = null;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc3_:Array = param2.tags;
         var _loc4_:String = param2.userName;
         var _loc5_:String = Boolean(param2.clanAbbrev) ? CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR;
         var _loc6_:String = Boolean(param2.region) ? Values.SPACE_STR + param2.region : Values.EMPTY_STR;
         var _loc7_:String = Values.EMPTY_STR;
         var _loc8_:uint = param1.textColor;
         if(_loc3_ && UserTags.isInIGR(_loc3_))
         {
            _loc7_ = Values.SPACE_STR + (!!UserTags.isBaseIGR(_loc3_) ? IMG_TAG_OPEN_PREMIUM : IMG_TAG_OPEN_BASIC) + param2.igrVspace + IMG_TAG_CLOSE;
         }
         var _loc9_:String = _loc4_ + _loc5_ + _loc6_ + _loc7_;
         var _loc11_:Number = param1.width;
         param1.htmlText = _loc9_;
         if(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
         {
            _loc10_ = true;
            _loc9_ = _loc4_ + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_;
            param1.htmlText = _loc9_;
            _loc12_ = param1.getCharBoundaries(_loc4_.length - 1);
            _loc13_ = param1.getCharBoundaries(_loc9_.length - 1);
            _loc14_ = _loc13_.x + _loc13_.width - (_loc12_.x + _loc12_.width);
            if(_loc14_ >= param1.width && param2.clanAbbrev)
            {
               _loc5_ = CLAN_TAG_OPEN + CUT_SYMBOLS_STR + CLAN_TAG_CLOSE;
               _loc9_ = _loc4_ + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_;
               _loc13_ = param1.getCharBoundaries(_loc9_.length - 1);
               _loc14_ = _loc13_.x + _loc13_.width - (_loc12_.x + _loc12_.width);
            }
            _loc15_ = _loc4_.length;
            while(_loc15_ > 0)
            {
               _loc13_ = param1.getCharBoundaries(_loc15_ - 1);
               if(_loc13_.x + _loc13_.width + _loc14_ <= _loc11_)
               {
                  break;
               }
               _loc15_--;
            }
            param1.htmlText = _loc4_.substr(0,_loc15_) + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_;
         }
         param1.textColor = _loc8_;
         return _loc10_;
      }
   }
}
