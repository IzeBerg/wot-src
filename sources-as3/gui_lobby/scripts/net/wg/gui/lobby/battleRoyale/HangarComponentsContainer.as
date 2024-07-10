package net.wg.gui.lobby.battleRoyale
{
   import flash.display.Sprite;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.lobby.hangar.HangarHeader;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HangarComponentsContainer extends Sprite implements IDisposable
   {
      
      private static const BATTLE_TYPE_SELECTOR_WIDTH:int = 1024;
      
      private static const BATTLE_TYPE_SELECTOR_HEIGHT:int = 70;
      
      private static const COMMANDER_WIDTH:int = 426;
      
      private static const COMMANDER_HEIGHT:int = 220;
      
      private static const COMMANDER_Y:int = 85;
      
      private static const PROXY_CURRENCY_PANEL_Y:int = 90;
      
      private static const COMMANDER_LAYER_NAME:String = "commander";
      
      private static const TECH_PARAMS_LAYER_NAME:String = "techParams";
      
      private static const BOTTOM_PANEL_LAYER_NAME:String = "bottomPanel";
      
      private static const PROXY_CURRENCY_LAYER_NAME:String = "proxyCurrencyPanel";
      
      private static const BATTLE_TYPE_SELECTOR_NAME:String = "battleTypeSelector";
       
      
      public var proxyCurrencyPanel:ProxyCurrencyPanel = null;
      
      public var commander:GFInjectComponent = null;
      
      public var battleTypeSelector:BattleTypeSelector = null;
      
      public var techParameters:TechParametersComponent = null;
      
      public var bottomPanel:BottomPanelComponent = null;
      
      private var _disposed:Boolean = false;
      
      private var _animationController:HeaderAnimationController = null;
      
      public function HangarComponentsContainer()
      {
         super();
         name = "BRComponentsContainer";
         this.techParameters = new TechParametersComponent();
         this.bottomPanel = new BottomPanelComponent();
         this.commander = new GFInjectComponent();
         this.proxyCurrencyPanel = new ProxyCurrencyPanel();
         this.battleTypeSelector = new BattleTypeSelector();
         this.techParameters.name = TECH_PARAMS_LAYER_NAME;
         this.bottomPanel.name = BOTTOM_PANEL_LAYER_NAME;
         this.commander.name = COMMANDER_LAYER_NAME;
         this.proxyCurrencyPanel.name = PROXY_CURRENCY_LAYER_NAME;
         this.battleTypeSelector.name = BATTLE_TYPE_SELECTOR_NAME;
         this.commander.setManageSize(true);
         this.commander.width = COMMANDER_WIDTH;
         this.commander.height = COMMANDER_HEIGHT;
         this.commander.y = COMMANDER_Y;
         this.proxyCurrencyPanel.x = App.appWidth - this.proxyCurrencyPanel.width;
         this.proxyCurrencyPanel.y = PROXY_CURRENCY_PANEL_Y;
         this.techParameters.x = App.appWidth - this.techParameters.width;
         this.techParameters.y = this.proxyCurrencyPanel.y + this.proxyCurrencyPanel.height;
         this.battleTypeSelector.setManageSize(true);
         this.battleTypeSelector.width = BATTLE_TYPE_SELECTOR_WIDTH;
         this.battleTypeSelector.height = BATTLE_TYPE_SELECTOR_HEIGHT;
         this.battleTypeSelector.x = App.appWidth - this.battleTypeSelector.width >> 1;
         addChild(this.bottomPanel);
         addChild(this.commander);
         addChild(this.techParameters);
         addChild(this.proxyCurrencyPanel);
         addChild(this.battleTypeSelector);
      }
      
      public final function dispose() : void
      {
         if(!this.isDisposed())
         {
            this._disposed = true;
            this.commander = null;
            this.techParameters = null;
            this.bottomPanel = null;
            this.proxyCurrencyPanel = null;
            this.battleTypeSelector = null;
            this._animationController.dispose();
            this._animationController = null;
         }
      }
      
      public function hideHeader() : void
      {
         this._animationController.hide();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setHeader(param1:HangarHeader) : void
      {
         if(!this._animationController)
         {
            this._animationController = new HeaderAnimationController(param1,this.battleTypeSelector);
         }
      }
      
      public function showHeader(param1:Boolean) : void
      {
         this._animationController.playShowAnimation(param1);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bottomPanel.x = param1 - this.bottomPanel.width >> 1;
         this.bottomPanel.y = param2 - this.bottomPanel.height;
         this.techParameters.x = param1 - this.techParameters.width;
         this.proxyCurrencyPanel.x = param1 - this.proxyCurrencyPanel.width;
         this.battleTypeSelector.x = param1 - this.battleTypeSelector.width >> 1;
      }
   }
}
