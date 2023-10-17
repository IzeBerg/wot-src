package net.wg.data.VO
{
   public class AnimationObject
   {
      
      private static const ARROW_BG_HEIGHT:Number = 134;
      
      private static const LIST_Y:Number = 212;
      
      private static const BGFORM_HEIGHT:Number = 323;
      
      private static const WINDOW_HEIGHT:Number = 401;
      
      private static const EXPANDBG_HEIGHT:Number = 37;
      
      private static const EXPANDBG_Y:Number = 176;
      
      private static const MARGIN:Number = 5;
      
      private static const BTNS_Y:Number = 326;
      
      private static const RESULT_Y:Number = 239;
      
      private static const SETTINGS_BTN_Y:Number = 173;
      
      private static const DROPDOWNRESULT_Y:Number = 166;
      
      private static const DEF_RESULT_Y:Number = 194;
      
      private static const DEF_BTNS_Y:Number = 280;
      
      private static const DEF_BGFORM_HEIGHT:Number = 277;
      
      private static const DEF_ARROW_BG_HEIGHT:Number = 89;
      
      private static const DEF_DROPDOWNRESULT_Y:Number = 145;
       
      
      private var _isOpen:Boolean = false;
      
      private var devHeight:Number = 0;
      
      private var listHeight:Number = 0;
      
      private var isEmpty:Boolean = true;
      
      public function AnimationObject(param1:Number, param2:Number, param3:Number)
      {
         super();
         this.devHeight = param1;
         this.listHeight = param2;
         this.isEmpty = param3 == 0;
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         this._isOpen = param1;
      }
      
      public function get settingsBtnY() : Number
      {
         return Math.round(SETTINGS_BTN_Y + this.devHeight);
      }
      
      public function get expandBgY() : Number
      {
         return Math.round(EXPANDBG_Y + this.devHeight);
      }
      
      public function get arrowBgHeight() : Number
      {
         if(!this.isEmpty)
         {
            if(this._isOpen)
            {
               return Math.round(ARROW_BG_HEIGHT + this.listHeight + this.devHeight);
            }
            return Math.round(ARROW_BG_HEIGHT + MARGIN + this.devHeight);
         }
         return Math.round(DEF_ARROW_BG_HEIGHT + this.devHeight);
      }
      
      public function get BtnsY() : Number
      {
         if(!this.isEmpty)
         {
            if(this._isOpen)
            {
               return Math.round(BTNS_Y + MARGIN + this.listHeight + this.devHeight);
            }
            return Math.round(BTNS_Y + this.devHeight);
         }
         return Math.round(DEF_BTNS_Y + this.devHeight);
      }
      
      public function get dropdownResultY() : Number
      {
         if(this._isOpen)
         {
            return Math.round(DROPDOWNRESULT_Y + this.listHeight + this.devHeight);
         }
         return Math.round(DEF_DROPDOWNRESULT_Y + this.devHeight);
      }
      
      public function get alpha() : Number
      {
         if(this._isOpen)
         {
            return 0;
         }
         return 1;
      }
      
      public function get expandBgHeight() : Number
      {
         if(this._isOpen)
         {
            return Math.round(EXPANDBG_HEIGHT + MARGIN + this.listHeight);
         }
         return Math.round(EXPANDBG_HEIGHT);
      }
      
      public function get maskMcHeight() : Number
      {
         if(this._isOpen)
         {
            return Math.round(this.listHeight - MARGIN);
         }
         return 0;
      }
      
      public function get maskMcY() : Number
      {
         return Math.round(LIST_Y + this.devHeight);
      }
      
      public function get slidingScrListY() : Number
      {
         if(this._isOpen)
         {
            return Math.round(LIST_Y + this.devHeight);
         }
         return 0;
      }
      
      public function get resultMcY() : Number
      {
         if(!this.isEmpty)
         {
            if(this._isOpen)
            {
               return Math.round(RESULT_Y + MARGIN + this.listHeight + this.devHeight);
            }
            return Math.round(RESULT_Y + this.devHeight);
         }
         return Math.round(DEF_RESULT_Y + this.devHeight);
      }
      
      public function get windBgFormHeight() : Number
      {
         if(!this.isEmpty)
         {
            if(this._isOpen)
            {
               return Math.round(BGFORM_HEIGHT + MARGIN + this.listHeight + this.devHeight);
            }
            return Math.round(BGFORM_HEIGHT + this.devHeight);
         }
         return Math.round(DEF_BGFORM_HEIGHT + this.devHeight);
      }
      
      public function get windBgHeight() : Number
      {
         if(this._isOpen)
         {
            return Math.round(WINDOW_HEIGHT + MARGIN + this.listHeight + this.devHeight);
         }
         return Math.round(WINDOW_HEIGHT + this.devHeight);
      }
   }
}
