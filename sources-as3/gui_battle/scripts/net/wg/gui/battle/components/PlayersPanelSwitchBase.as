package net.wg.gui.battle.components
{
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButton;
   
   public class PlayersPanelSwitchBase extends BattleUIComponent implements IClickButtonHandler
   {
      
      protected static const DISABLED_ALPHA:Number = 0.5;
       
      
      public var hidenBt:PlayersPanelSwitchButton = null;
      
      public var shortBt:PlayersPanelSwitchButton = null;
      
      public var mediumBt:PlayersPanelSwitchButton = null;
      
      public var longBt:PlayersPanelSwitchButton = null;
      
      public var fullBt:PlayersPanelSwitchButton = null;
      
      protected var state:int = -1;
      
      protected var selectedBt:PlayersPanelSwitchButton = null;
      
      private var _isInteractive:Boolean = false;
      
      public function PlayersPanelSwitchBase()
      {
         super();
         alpha = DISABLED_ALPHA;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.setIsInteractive(false);
         this.hidenBt.dispose();
         this.shortBt.dispose();
         this.mediumBt.dispose();
         this.longBt.dispose();
         this.fullBt.dispose();
         this.hidenBt = null;
         this.shortBt = null;
         this.mediumBt = null;
         this.longBt = null;
         this.fullBt = null;
         this.selectedBt = null;
         super.onDispose();
      }
      
      public function onButtonClick(param1:Object) : void
      {
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         if(this._isInteractive == param1)
         {
            return;
         }
         alpha = !!param1 ? Number(1) : Number(DISABLED_ALPHA);
         if(param1)
         {
            this.hidenBt.addClickCallBack(this);
            this.shortBt.addClickCallBack(this);
            this.mediumBt.addClickCallBack(this);
            this.longBt.addClickCallBack(this);
            this.fullBt.addClickCallBack(this);
         }
         this._isInteractive = param1;
      }
      
      public function setState(param1:int) : void
      {
      }
   }
}
