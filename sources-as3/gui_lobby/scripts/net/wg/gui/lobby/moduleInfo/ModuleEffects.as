package net.wg.gui.lobby.moduleInfo
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   
   public class ModuleEffects extends UIComponentEx
   {
      
      private static const MARGIN_BETWEEN_EFFECTS:int = 25;
      
      private static const COLOR_EFFECT:String = "#cbad78";
      
      private static const SIZE_EFFECT_TITLE:uint = 14;
      
      private static const SIZE_EFFECT:uint = 13;
      
      private static const TAG_BR:String = "<br/>";
      
      private static const COLOR_EQUIPMENT_USAGE:String = "#c1ba9c";
      
      private static const SIZE_EQUIPMENT_USAGE:uint = 13;
      
      private static const COLOR_EQUIPMENT_USAGE_BODY:String = "#95907f";
      
      private static const SIZE_EQUIPMENT_USAGE_BODY:uint = 12;
      
      private static const FIELD_FONT:String = "$FieldFont";
      
      private static const TITLE_FONT:String = "$TitleFont";
       
      
      public var effectsTF:TextField = null;
      
      private var _bottomMargin:Number = 20;
      
      public function ModuleEffects()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.effectsTF = null;
         super.onDispose();
      }
      
      public function setEffects(param1:Object = null) : void
      {
         if(param1)
         {
            this.effectsTF.multiline = true;
            this.effectsTF.autoSize = TextFieldAutoSize.LEFT;
            this.effectsTF.multiline = true;
            this.effectsTF.htmlText = this.getEffectParams(param1);
            height = this.effectsTF.y + this.effectsTF.textHeight + this._bottomMargin;
         }
      }
      
      [Inspectable(defaultValue="20",name="bottomMargin",type="Number")]
      public function get bottomMargin() : Number
      {
         return this._bottomMargin;
      }
      
      public function set bottomMargin(param1:Number) : void
      {
         this._bottomMargin = param1;
      }
      
      private function getEffectParams(param1:Object) : String
      {
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:ILocale = App.utils.locale;
         if(param1.effectOnUse && param1.effectOnUse != Values.EMPTY_STR && param1.effectOnUse != undefined)
         {
            _loc2_ += this.getEquipmentUsageBlock(_loc3_.makeString(TOOLTIPS.EQUIPMENT_ONUSE),_loc3_.makeString(param1.effectOnUse),MARGIN_BETWEEN_EFFECTS);
         }
         if(param1.effectAlways != Values.EMPTY_STR && param1.effectAlways != Values.EMPTY_STR && param1.effectAlways != undefined)
         {
            _loc2_ += this.getEquipmentUsageBlock(_loc3_.makeString(TOOLTIPS.EQUIPMENT_ALWAYS),_loc3_.makeString(param1.effectAlways),MARGIN_BETWEEN_EFFECTS);
         }
         if(_loc2_ != Values.EMPTY_STR)
         {
            _loc2_ = Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.EQUIPMENT_EFFECT),COLOR_EFFECT,SIZE_EFFECT_TITLE,TITLE_FONT) + _loc2_;
         }
         if(param1.effectRestriction != Values.EMPTY_STR && param1.effectRestriction != Values.EMPTY_STR && param1.effectRestriction != undefined)
         {
            _loc2_ += TAG_BR + Utils.instance.htmlWrapper(Values.EMPTY_STR,COLOR_EFFECT,SIZE_EFFECT,FIELD_FONT) + TAG_BR + Utils.instance.htmlWrapper(App.utils.locale.makeString(param1.effectRestriction),COLOR_EFFECT,SIZE_EFFECT,FIELD_FONT);
         }
         return _loc2_;
      }
      
      private function getEquipmentUsageBlock(param1:String, param2:String, param3:int = 20) : String
      {
         param1 = param1 == "" ? "" : Utils.instance.htmlWrapper(param1,COLOR_EQUIPMENT_USAGE,SIZE_EQUIPMENT_USAGE,FIELD_FONT) + Utils.instance.htmlWrapper(Values.SPACE_STR,COLOR_EQUIPMENT_USAGE,param3,FIELD_FONT);
         param2 = param2 == "" ? "" : Utils.instance.htmlWrapper(param2,COLOR_EQUIPMENT_USAGE_BODY,SIZE_EQUIPMENT_USAGE_BODY,FIELD_FONT);
         return TAG_BR + param1 + TAG_BR + param2;
      }
   }
}
