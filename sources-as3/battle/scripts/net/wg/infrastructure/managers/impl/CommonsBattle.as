package net.wg.infrastructure.managers.impl
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.managers.utils.impl.CommonsBase;
   
   public class CommonsBattle extends CommonsBase
   {
      
      private static const IGR_TYPE_PREMIUM:int = 2;
       
      
      public function CommonsBattle()
      {
         super();
      }
      
      private static function cutPlayerName(param1:TextField, param2:String, param3:String) : Boolean
      {
         var _loc4_:int = 4;
         var _loc5_:uint = param2.length;
         if(_loc5_ <= _loc4_)
         {
            param1.htmlText = param2 + param3;
         }
         else
         {
            param1.htmlText = param2 + CUT_SYMBOLS_STR + param3;
         }
         var _loc6_:Number = param1.width;
         var _loc7_:Number = param1.length - 1;
         var _loc8_:Rectangle = param1.getCharBoundaries(_loc5_ - 1);
         var _loc9_:Rectangle = param1.getCharBoundaries(_loc7_);
         var _loc10_:Number = _loc9_.x + _loc9_.width - (_loc8_.x + _loc8_.width);
         var _loc11_:Rectangle = param1.getCharBoundaries(0);
         if(_loc5_ <= _loc4_)
         {
            return _loc8_.x + _loc8_.width - _loc11_.x + _loc10_ + TEXT_FIELD_BOUNDS_WIDTH <= _loc6_;
         }
         var _loc12_:int = _loc5_;
         while(_loc12_ >= _loc4_)
         {
            _loc8_ = param1.getCharBoundaries(_loc12_ - 1);
            _loc5_ = _loc12_;
            if(_loc8_.x + _loc8_.width - _loc11_.x + _loc10_ + TEXT_FIELD_BOUNDS_WIDTH <= _loc6_)
            {
               _loc12_--;
               break;
            }
            _loc12_--;
         }
         param1.htmlText = param2.substr(0,_loc5_) + CUT_SYMBOLS_STR + param3;
         return _loc12_ >= _loc4_;
      }
      
      private static function formatIgrStr(param1:Array, param2:int) : String
      {
         var _loc3_:String = Values.EMPTY_STR;
         if(param1 && UserTags.isInIGR(param1))
         {
            _loc3_ = !!UserTags.isBaseIGR(param1) ? IMG_TAG_OPEN_BASIC : IMG_TAG_OPEN_PREMIUM;
            return Values.SPACE_STR + _loc3_ + param2 + IMG_TAG_CLOSE;
         }
         return _loc3_;
      }
      
      override public function formatPlayerName(param1:TextField, param2:IUserProps, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc11_:Boolean = false;
         var _loc12_:String = null;
         var _loc13_:Vector.<String> = null;
         var _loc14_:int = 0;
         var _loc5_:String = param2.userName;
         var _loc6_:String = Boolean(param2.clanAbbrev) ? CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR;
         var _loc7_:String = Boolean(param2.region) ? Values.SPACE_STR + param2.region : Values.EMPTY_STR;
         var _loc8_:String = formatIgrStr(param2.tags,param2.igrVspace);
         var _loc9_:uint = param1.textColor;
         var _loc10_:String = param2.isAnonymized && param4 ? Values.SPACE_STR + IMG_TAG_EYE_ICON : Values.EMPTY_STR;
         param1.htmlText = _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc10_;
         if(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
         {
            _loc11_ = true;
            _loc12_ = _loc7_ + _loc8_ + _loc10_;
            _loc13_ = new <String>[Values.EMPTY_STR,_loc6_,_loc8_,_loc12_,_loc6_ + _loc12_];
            _loc14_ = _loc13_.length - 1;
            while(_loc14_ >= 0)
            {
               if(cutPlayerName(param1,_loc5_,_loc13_[_loc14_]))
               {
                  break;
               }
               _loc14_--;
            }
         }
         param1.textColor = _loc9_;
         return _loc11_;
      }
      
      override public function getFullPlayerName(param1:IUserProps, param2:Boolean = false) : String
      {
         if(param1.isAnonymized && param2)
         {
            return param1.prefix + param1.fakeName + param1.suffix;
         }
         var _loc3_:String = (param1.igrType == IGR_TYPE_PREMIUM ? IMG_TAG_OPEN_PREMIUM : IMG_TAG_OPEN_BASIC) + param1.igrVspace + IMG_TAG_CLOSE;
         return param1.prefix + param1.userName + (Boolean(param1.clanAbbrev) ? CLAN_TAG_OPEN + param1.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR) + (Boolean(param1.region) ? Values.SPACE_STR + param1.region : Values.EMPTY_STR) + (param1.igrType > 0 ? Values.SPACE_STR + _loc3_ : Values.EMPTY_STR) + param1.suffix;
      }
   }
}
