package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.battle.commander.views.spawnMenu.events.SpawnMenuEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   
   public class Footer extends StagedItem
   {
       
      
      public var battleBtn:UniversalBtn = null;
      
      public var footerBg:MovieClip = null;
      
      private var _battleButtonText:String = null;
      
      private var _isBattleBtnEnabled:Boolean = false;
      
      public function Footer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleBtn.enabled = false;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.footerBg = null;
         this.removeListeners();
         this.battleBtn.dispose();
         this.battleBtn = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            App.utils.universalBtnStyles.setStyle(this.battleBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
            this.removeListeners();
            this.addListeners();
         }
         if(isInvalid(InvalidationType.SIZE | InvalidationType.DATA))
         {
            this.battleBtn.enabled = this._isBattleBtnEnabled;
            this.battleBtn.label = this._battleButtonText;
         }
      }
      
      public function setBattleButtonText(param1:String) : void
      {
         this._battleButtonText = param1;
         invalidateData();
      }
      
      public function setIsBattleBtnEnabled(param1:Boolean) : void
      {
         this._isBattleBtnEnabled = param1;
         invalidateData();
      }
      
      private function onBattleClick(param1:MouseEvent) : void
      {
         dispatchEvent(new SpawnMenuEvent(SpawnMenuEvent.BATTLE));
      }
      
      private function addListeners() : void
      {
         this.battleBtn.addEventListener(MouseEvent.CLICK,this.onBattleClick);
      }
      
      private function removeListeners() : void
      {
         this.battleBtn.removeEventListener(MouseEvent.CLICK,this.onBattleClick);
      }
   }
}
