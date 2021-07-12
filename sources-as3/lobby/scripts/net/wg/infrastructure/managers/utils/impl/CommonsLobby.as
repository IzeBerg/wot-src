package net.wg.infrastructure.managers.utils.impl
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class CommonsLobby extends CommonsBase
   {
      
      private static const IGR_TYPE_PREMIUM:int = 2;
      
      private static const MIN_NAME_LENGTH:int = 5;
       
      
      public function CommonsLobby()
      {
         super();
      }
      
      private static function formatIgrStr(param1:Array, param2:int, param3:int) : String
      {
         var _loc4_:String = Values.EMPTY_STR;
         if(param2 > 0)
         {
            _loc4_ = (param2 == IGR_TYPE_PREMIUM ? IMG_TAG_OPEN_PREMIUM : IMG_TAG_OPEN_BASIC) + param3;
         }
         else if(UserTags.isBaseIGR(param1))
         {
            _loc4_ = IMG_TAG_OPEN_BASIC + param3;
         }
         else
         {
            if(!UserTags.isPremiumIGR(param1))
            {
               return _loc4_;
            }
            _loc4_ = IMG_TAG_OPEN_PREMIUM + param3;
         }
         return Values.SPACE_STR + _loc4_ + IMG_TAG_CLOSE;
      }
      
      override public function formatPlayerName(param1:TextField, param2:IUserProps, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc19_:int = 0;
         var _loc5_:TextFormat = param1.getTextFormat();
         var _loc6_:Object = _loc5_.size;
         var _loc7_:String = _loc5_.font;
         var _loc8_:String = _loc5_.align;
         var _loc9_:String = param2.prefix;
         var _loc10_:String = Values.EMPTY_STR;
         var _loc11_:String = Values.EMPTY_STR;
         var _loc12_:String = Values.EMPTY_STR;
         var _loc13_:String = Values.EMPTY_STR;
         var _loc14_:String = param2.suffix;
         var _loc15_:String = Values.EMPTY_STR;
         var _loc16_:String = param2.isAnonymized && param4 ? Values.SPACE_STR + IMG_TAG_EYE_ICON : Values.EMPTY_STR;
         if(param2.isAnonymized && param3)
         {
            _loc10_ = param2.fakeName;
            _loc15_ = _loc14_ + _loc16_;
         }
         else
         {
            _loc10_ = param2.userName;
            if(param2.clanAbbrev)
            {
               _loc11_ = CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE;
            }
            if(param2.region)
            {
               _loc12_ = Values.SPACE_STR + param2.region;
            }
            _loc13_ = formatIgrStr(param2.tags,param2.igrType,param2.igrVspace);
            _loc15_ = _loc12_ + _loc13_ + _loc14_ + _loc16_;
         }
         var _loc17_:String = _loc9_ + _loc10_ + _loc11_ + _loc15_;
         applyTextProps(param1,_loc17_,_loc5_,_loc6_,_loc7_,_loc8_);
         var _loc18_:Boolean = false;
         if(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
         {
            _loc18_ = true;
            _loc17_ = _loc9_ + _loc10_.substr(0,MIN_NAME_LENGTH) + CUT_SYMBOLS_STR + _loc11_ + _loc15_;
            applyTextProps(param1,_loc17_,_loc5_,_loc6_,_loc7_,_loc8_);
            if(param1.width >= param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
            {
               _loc15_ = _loc11_ + _loc15_;
            }
            _loc19_ = _loc10_.length - 1;
            do
            {
               _loc17_ = _loc9_ + _loc10_.substr(0,_loc19_) + CUT_SYMBOLS_STR + _loc15_;
               applyTextProps(param1,_loc17_,_loc5_,_loc6_,_loc7_,_loc8_);
               _loc19_--;
            }
            while(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH && _loc19_ > 0);
            
         }
         if(!isNaN(param2.rgb))
         {
            param1.textColor = param2.rgb;
         }
         if(param2.isTeamKiller)
         {
            param1.setTextFormat(TEAM_KILLER_FORMAT,_loc9_.length,param1.text.length - _loc15_.length);
         }
         return _loc18_;
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
