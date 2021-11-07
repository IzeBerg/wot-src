package net.wg.gui.battle.epicBattle.battleloading.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EpicBattleLoadingTankTypeComponent extends BattleUIComponent
   {
      
      private static const NORMAL_IMAGE_POSTFIX:String = "Normal";
      
      private static const DESTROYED_IMAGE_POSTFIX:String = "Destroyed";
       
      
      public var tankTypeMarker:Sprite = null;
      
      public var tankCounterTF:TextField = null;
      
      private var _tankType:String = "";
      
      private var _isActive:Boolean = false;
      
      private var _color:String = "";
      
      private var _tankTypeCount:String = "";
      
      private var _atlasManager:IAtlasManager;
      
      public function EpicBattleLoadingTankTypeComponent()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.loadMarker();
            this.tankCounterTF.text = this._tankTypeCount;
         }
      }
      
      override protected function onDispose() : void
      {
         this.tankTypeMarker = null;
         this.tankCounterTF = null;
         this._atlasManager = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:int, param3:String) : void
      {
         this._tankType = param1;
         this._isActive = param2 > 0;
         this._tankTypeCount = param2.toString();
         this._color = param3.toLowerCase();
         invalidateData();
      }
      
      private function loadMarker() : void
      {
         var _loc1_:String = !!this._isActive ? NORMAL_IMAGE_POSTFIX : DESTROYED_IMAGE_POSTFIX;
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this._color + this._tankType + _loc1_,this.tankTypeMarker.graphics);
      }
   }
}
