package net.wg.gui.tutorial.controls
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleBonusItem extends UIComponentEx
   {
      
      private static const STATE_HAS_BONUSES:String = "has_bonuses";
      
      private static const STATE_NO_BONUSES:String = "no_bonuses";
       
      
      private var _hasBonusesTitle:String = "";
      
      private var _noBonusesTitle:String = "";
      
      private var _noBonusesDescription:String = "";
      
      private var _credits:Number;
      
      private var _freeXP:Number;
      
      public var titleField:TextField;
      
      public var descriptionField:TextField;
      
      public var valueField:TextField;
      
      public function BattleBonusItem()
      {
         super();
      }
      
      [Inspectable(defaultValue="",name="hasBonusesTitle",type="String")]
      public function get hasBonusesTitle() : String
      {
         return this._hasBonusesTitle;
      }
      
      public function set hasBonusesTitle(param1:String) : void
      {
         this._hasBonusesTitle = param1;
         invalidate();
      }
      
      [Inspectable(defaultValue="",name="noBonusesTitle",type="String")]
      public function get noBonusesTitle() : String
      {
         return this._noBonusesTitle;
      }
      
      public function set noBonusesTitle(param1:String) : void
      {
         this._noBonusesTitle = param1;
         invalidate();
      }
      
      [Inspectable(defaultValue="",name="noBonusesDescription",type="String")]
      public function get noBonusesDescription() : String
      {
         return this._noBonusesDescription;
      }
      
      public function set noBonusesDescription(param1:String) : void
      {
         this._noBonusesDescription = param1;
         invalidate();
      }
      
      public function setBonuses(param1:Number, param2:Number) : void
      {
         if(this._credits == param1 && this._freeXP == param2)
         {
            return;
         }
         this._credits = !!isNaN(param1) ? Number(0) : Number(param1);
         this._freeXP = !!isNaN(param2) ? Number(0) : Number(param2);
         invalidate();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleField.wordWrap = true;
         this.descriptionField.wordWrap = true;
         this.valueField.wordWrap = true;
         this.valueField.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = this._credits > 0 || this._freeXP > 0;
         if(_loc1_)
         {
            gotoAndStop(STATE_HAS_BONUSES);
            this.setBonusesTextFields();
         }
         else
         {
            gotoAndStop(STATE_NO_BONUSES);
            this.setNoBonusesTextFields();
         }
      }
      
      private function setBonusesTextFields() : void
      {
         this.titleField.autoSize = TextFieldAutoSize.RIGHT;
         this.titleField.text = this._hasBonusesTitle;
         var _loc1_:ILocale = App.utils.locale;
         this.valueField.htmlText = _loc1_.integer(this._credits) + "<br/>" + _loc1_.integer(this._freeXP);
         this.descriptionField.autoSize = TextFieldAutoSize.RIGHT;
         this.descriptionField.htmlText = _loc1_.makeString(BATTLE_TUTORIAL.LABELS_CREDITS) + "<br/>" + _loc1_.makeString(BATTLE_TUTORIAL.LABELS_FREE_XP);
         TextFieldEx.setVerticalAlign(this.titleField,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.valueField,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.descriptionField,TextFieldEx.VALIGN_CENTER);
      }
      
      private function setNoBonusesTextFields() : void
      {
         this.titleField.autoSize = TextFieldAutoSize.CENTER;
         this.titleField.text = this._noBonusesTitle;
         TextFieldEx.setVerticalAlign(this.titleField,TextFieldEx.VALIGN_CENTER);
      }
   }
}
