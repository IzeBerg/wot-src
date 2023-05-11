package net.wg.gui.battle.epicBattle.battleloading.components
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.DAMAGEINDICATOR;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class EpicBattleLoadingTankBalance extends BattleUIComponent
   {
      
      private static const FRAG_CORRELATION_WIN:String = "FragCorrelationWin";
      
      private static const FRAG_CORRELATION_LOSE:String = "FragCorrelationLoose";
       
      
      public var heavyTankComponent:EpicBattleLoadingTankTypeComponent;
      
      public var mediumTankComponent:EpicBattleLoadingTankTypeComponent;
      
      public var lightTankComponent:EpicBattleLoadingTankTypeComponent;
      
      public var tankDestroyerComponent:EpicBattleLoadingTankTypeComponent;
      
      public var spgComponent:EpicBattleLoadingTankTypeComponent;
      
      private var _color:String = "";
      
      private var _isAllyTankBalance:Boolean = false;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _tankTypeCounter:Vector.<int>;
      
      private var _tankComponents:Vector.<EpicBattleLoadingTankTypeComponent> = null;
      
      private var _tankTypeToElement:Vector.<String>;
      
      public function EpicBattleLoadingTankBalance()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         this._tankTypeCounter = new <int>[0,0,0,0,0];
         this._tankTypeToElement = new <String>[DAMAGEINDICATOR.HEAVY_TANK,DAMAGEINDICATOR.MEDIUM_TANK,DAMAGEINDICATOR.LIGHT_TANK,DAMAGEINDICATOR.AT_SPG,DAMAGEINDICATOR.SPG];
         super();
         this._tankTypeCounter = new <int>[0,0,0,0,0];
         this._tankComponents = new <EpicBattleLoadingTankTypeComponent>[this.heavyTankComponent,this.mediumTankComponent,this.lightTankComponent,this.tankDestroyerComponent,this.spgComponent];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this._tankTypeCounter.splice(0,this._tankTypeCounter.length);
         this._tankTypeCounter = null;
         this._tankTypeToElement.splice(0,this._tankTypeToElement.length);
         this._tankTypeToElement = null;
         this._tankComponents.splice(0,this._tankComponents.length);
         this._tankComponents = null;
         this.heavyTankComponent.dispose();
         this.heavyTankComponent = null;
         this.mediumTankComponent.dispose();
         this.mediumTankComponent = null;
         this.lightTankComponent.dispose();
         this.lightTankComponent = null;
         this.tankDestroyerComponent.dispose();
         this.tankDestroyerComponent = null;
         this.spgComponent.dispose();
         this.spgComponent = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._tankComponents.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._tankComponents[_loc2_].setData(this._tankTypeToElement[_loc2_],this._tankTypeCounter[_loc2_],this._color);
               _loc2_++;
            }
         }
      }
      
      public function setVehiclesData(param1:Array) : void
      {
         var _loc4_:DAAPIVehicleInfoVO = null;
         this.evaluateColor();
         this.clearTypeCounter();
         var _loc2_:int = param1.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = DAAPIVehicleInfoVO(param1[_loc3_]);
            if(_loc4_.isAlive())
            {
               this._tankTypeCounter[this._tankTypeToElement.indexOf(_loc4_.vehicleType)] = this._tankTypeCounter[this._tankTypeToElement.indexOf(_loc4_.vehicleType)] + 1;
            }
            _loc3_++;
         }
         invalidateData();
      }
      
      private function clearTypeCounter() : void
      {
         this._tankTypeCounter = new <int>[0,0,0,0,0];
      }
      
      private function evaluateColor() : void
      {
         var _loc1_:String = !!this._isAllyTankBalance ? this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN).aliasColor : this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE).aliasColor;
         this._color = _loc1_;
         invalidateData();
      }
      
      public function set isAllyTankBalance(param1:Boolean) : void
      {
         if(this._isAllyTankBalance == param1)
         {
            return;
         }
         this._isAllyTankBalance = param1;
         this.evaluateColor();
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.evaluateColor();
      }
   }
}
