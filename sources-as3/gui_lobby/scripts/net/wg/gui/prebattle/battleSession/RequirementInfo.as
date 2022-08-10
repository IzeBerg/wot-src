package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class RequirementInfo extends UIComponentEx
   {
       
      
      public var flagList:FlagsList;
      
      public var requiredNationText:TextField;
      
      public var heavyLevelField:TextField;
      
      public var mediumLevelField:TextField;
      
      public var lightLevelField:TextField;
      
      public var atspgLevelField:TextField;
      
      public var spgLevelField:TextField;
      
      public var requiredTypeText:TextField;
      
      public var icons:MovieClip;
      
      private var _textFields:Object;
      
      public function RequirementInfo()
      {
         super();
         this._textFields = {
            "lightTank":this.lightLevelField,
            "mediumTank":this.mediumLevelField,
            "heavyTank":this.heavyLevelField,
            "SPG":this.spgLevelField,
            "AT-SPG":this.atspgLevelField
         };
      }
      
      public function get textFields() : Object
      {
         return this._textFields;
      }
   }
}
