package net.wg.gui.lobby.battleRoyale
{
   import flash.display.Sprite;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.containers.inject.UssInjectComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HangarComponentsContainer extends Sprite implements IDisposable
   {
      
      private static const COMMANDER_WIDTH:int = 426;
      
      private static const COMMANDER_HEIGHT:int = 220;
      
      private static const COMMANDER_Y:int = 51;
      
      private static const PROXY_CURRENCY_PANEL_Y:int = 43;
      
      private static const TECH_PARAMETERS_MARGIN_TOP:int = 2;
      
      private static const COMNANDER_LAYER_NAME:String = "commander";
      
      private static const TECH_PARAMS_LAYER_NAME:String = "techParams";
      
      private static const BOTTOM_PANEL_LAYER_NAME:String = "bottomPanel";
      
      private static const PROXY_CURRENCY_LAYER_NAME:String = "proxyCurrencyPanel";
       
      
      public var proxyCurrencyPanel:ProxyCurrencyPanel = null;
      
      public var commander:GFInjectComponent = null;
      
      public var techParameters:TechParametersComponent = null;
      
      public var bottomPanel:UssInjectComponent = null;
      
      private var _disposed:Boolean = false;
      
      public function HangarComponentsContainer()
      {
         super();
         this.techParameters = new TechParametersComponent();
         this.bottomPanel = new UssInjectComponent();
         this.commander = new GFInjectComponent();
         this.proxyCurrencyPanel = new ProxyCurrencyPanel();
         this.techParameters.name = TECH_PARAMS_LAYER_NAME;
         this.bottomPanel.name = BOTTOM_PANEL_LAYER_NAME;
         this.commander.name = COMNANDER_LAYER_NAME;
         this.proxyCurrencyPanel.name = PROXY_CURRENCY_LAYER_NAME;
         this.commander.setManageSize(true);
         this.commander.width = COMMANDER_WIDTH;
         this.commander.height = COMMANDER_HEIGHT;
         this.commander.y = COMMANDER_Y;
         this.proxyCurrencyPanel.x = App.appWidth - this.proxyCurrencyPanel.width;
         this.proxyCurrencyPanel.y = PROXY_CURRENCY_PANEL_Y;
         this.techParameters.x = App.appWidth - this.techParameters.width;
         this.techParameters.y = this.proxyCurrencyPanel.y + this.proxyCurrencyPanel.height + TECH_PARAMETERS_MARGIN_TOP;
         addChild(this.commander);
         addChild(this.techParameters);
         addChild(this.bottomPanel);
         addChild(this.proxyCurrencyPanel);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.commander = null;
         this.techParameters = null;
         this.bottomPanel = null;
         this.proxyCurrencyPanel = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bottomPanel.y = param2;
         this.techParameters.x = param1 - this.techParameters.width;
         this.proxyCurrencyPanel.x = param1 - this.proxyCurrencyPanel.width;
      }
   }
}
