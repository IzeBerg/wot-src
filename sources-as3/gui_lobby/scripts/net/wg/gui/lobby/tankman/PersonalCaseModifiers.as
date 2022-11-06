package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   
   public class PersonalCaseModifiers extends UIComponentEx
   {
      
      private static const MODIFIER_COLOR_NORMAL:String = "#FFFFFF";
      
      private static const MODIFIER_COLOR_ALERT:String = "#b70000";
      
      private static const MODIFIER_TEXT_SIZE:uint = 16;
      
      private static const MODIFIER_HEADER_TEXT_SIZE:uint = 16;
      
      private static const MODIFIER_ADDITIONAL_HEIGHT:uint = 5;
      
      private static const BR_TAG:String = "<br/>";
       
      
      public var modifiersHeaders:TextField;
      
      public var modifiersValues:TextField;
      
      public var modifiersNames:TextField;
      
      public function PersonalCaseModifiers()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.modifiersHeaders = null;
         this.modifiersValues = null;
         this.modifiersNames = null;
         super.onDispose();
      }
      
      public function setData(param1:Array, param2:Number) : void
      {
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc3_:ILocale = App.utils.locale;
         this.modifiersHeaders.htmlText = _loc3_.makeString(MENU.TANKMANPERSONALCASE_MODIFIERSHEADER);
         this.modifiersValues.htmlText = Values.EMPTY_STR;
         this.modifiersNames.htmlText = Values.EMPTY_STR;
         var _loc4_:Number = 0;
         var _loc5_:String = Values.EMPTY_STR;
         var _loc6_:Boolean = false;
         if(param1 && param1.length > 0)
         {
            _loc8_ = param1.length;
            _loc10_ = false;
            _loc11_ = 0;
            while(_loc11_ < _loc8_)
            {
               _loc9_ = param1[_loc11_];
               if(_loc9_.val != 0)
               {
                  _loc6_ = true;
                  if(_loc9_.val > 0)
                  {
                     _loc5_ = "+";
                     _loc7_ = MODIFIER_COLOR_NORMAL;
                  }
                  else
                  {
                     _loc5_ = Values.EMPTY_STR;
                     _loc7_ = MODIFIER_COLOR_ALERT;
                     _loc10_ = true;
                  }
                  _loc4_ += _loc9_.val;
                  if(_loc11_ != param1.length - 1)
                  {
                     this.modifiersHeaders.htmlText += BR_TAG;
                  }
                  this.modifiersValues.htmlText += "<font color=\"" + _loc7_ + "\">" + _loc5_ + _loc9_.val + "%</font>" + BR_TAG;
                  this.modifiersNames.htmlText += _loc3_.makeString(MENU.tankmanpersonalcase_modifiers(_loc9_.id)) + BR_TAG;
                  while(this.modifiersNames.numLines > this.modifiersValues.numLines)
                  {
                     this.modifiersHeaders.htmlText += BR_TAG;
                     this.modifiersValues.htmlText += BR_TAG;
                  }
               }
               _loc11_++;
            }
            if(_loc6_)
            {
               this.modifiersHeaders.htmlText += "<font size=\"" + MODIFIER_HEADER_TEXT_SIZE + "\"> </font>" + _loc3_.makeString(MENU.TANKMANPERSONALCASE_MODIFIERSRESULT);
               _loc12_ = !!_loc10_ ? MODIFIER_COLOR_ALERT : MODIFIER_COLOR_NORMAL;
               this.modifiersValues.htmlText += "<font color=\"" + _loc12_ + "\" size=\"" + MODIFIER_TEXT_SIZE + "\">" + (param2 + _loc4_).toString() + "%</font>";
            }
            else
            {
               this.addNoModifiersInfo();
            }
         }
         else
         {
            this.addNoModifiersInfo();
         }
         this.modifiersHeaders.height = Math.max(this.modifiersNames.textHeight,Math.max(this.modifiersHeaders.textHeight,this.modifiersValues.textHeight)) + MODIFIER_ADDITIONAL_HEIGHT;
         this.modifiersValues.height = this.modifiersNames.height = this.modifiersHeaders.height;
      }
      
      private function addNoModifiersInfo() : void
      {
         this.modifiersValues.htmlText = COMMON.COMMON_DASH;
         this.modifiersNames.htmlText = MENU.TANKMANPERSONALCASE_NOMODIFIERS;
         var _loc1_:TextFormat = this.modifiersNames.getTextFormat();
         _loc1_.leading = 0;
         this.modifiersNames.setTextFormat(_loc1_);
      }
   }
}
