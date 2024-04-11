package net.wg.gui.battle.historicalBattles.playersPanel.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HBDynamicSquad extends BattleUIComponent
   {
       
      
      public var icon:BattleAtlasSprite = null;
      
      public var squadIndexTF:TextField = null;
      
      private var _squadIndex:int = 0;
      
      private var _isPlayerInSquad:Boolean = false;
      
      public function HBDynamicSquad()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.squadIndexTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._squadIndex > 0 && isInvalid(InvalidationType.DATA))
         {
            this.validateData();
            this.validatePosition();
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.squadIndexTF = null;
         super.onDispose();
      }
      
      public function setData(param1:int, param2:Boolean) : void
      {
         if(param1 == this._squadIndex && this._isPlayerInSquad == param2)
         {
            return;
         }
         this._squadIndex = param1;
         this._isPlayerInSquad = param2;
         invalidateData();
      }
      
      override public function set alpha(param1:Number) : void
      {
         this.icon.alpha = param1;
      }
      
      private function validateData() : void
      {
         this.squadIndexTF.text = this._squadIndex.toString();
         this.icon.imageName = !!this._isPlayerInSquad ? BATTLEATLAS.HB_SQUAD_GOLD : BATTLEATLAS.HB_SQUAD_SILVER;
      }
      
      private function validatePosition() : void
      {
         this.squadIndexTF.x = this.icon.width - this.squadIndexTF.width >> 1;
         this.squadIndexTF.y = this.icon.height - this.squadIndexTF.height >> 1;
      }
   }
}
