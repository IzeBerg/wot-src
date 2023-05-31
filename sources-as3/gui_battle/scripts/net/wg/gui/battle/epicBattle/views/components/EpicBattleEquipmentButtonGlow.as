package net.wg.gui.battle.epicBattle.views.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButtonGlow;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicBattleEquipmentButtonGlow extends BattleEquipmentButtonGlow
   {
       
      
      public var tfLevelContainer:MovieClip = null;
      
      private var _levelTextField:TextField = null;
      
      private var _romanNumbersDict:Object;
      
      public function EpicBattleEquipmentButtonGlow()
      {
         this._romanNumbersDict = {
            1:"I",
            2:"II",
            3:"III",
            4:"IV"
         };
         super();
      }
      
      public function setLevel(param1:int) : void
      {
         var _loc2_:String = param1.toString();
         this._levelTextField.text = !!this._romanNumbersDict.hasOwnProperty(_loc2_) ? this._romanNumbersDict[_loc2_] : "";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._levelTextField = this.tfLevelContainer.levelTextField;
         TextFieldEx.setNoTranslate(this._levelTextField,true);
      }
      
      override protected function onDispose() : void
      {
         this.tfLevelContainer = null;
         this._levelTextField = null;
         this._romanNumbersDict = null;
         super.onDispose();
      }
   }
}
