package net.wg.gui.lobby.battleRoyale.vehicleInfoView.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.battleRoyale.IConfiguratorRenderer;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorModuleVO;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   
   public class ConfiguratorRenderer extends MovieClip implements IConfiguratorRenderer
   {
      
      private static const ACTIVE_FRAME_LABEL:String = "active";
      
      private static const DISABLED_FRAME_LABEL:String = "disabled";
       
      
      public var icon:Sprite = null;
      
      private var _moduleIntCD:int = -1;
      
      private var _columnIdx:uint = 0;
      
      private var _moduleIdx:uint = 0;
      
      private var _active:Boolean = false;
      
      private var _icon:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _scheduler:IScheduler;
      
      private var _soundMgr:ISoundManager;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _tooltipEnabled:Boolean = true;
      
      private var _baseDisposed:Boolean = false;
      
      public function ConfiguratorRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._scheduler = App.utils.scheduler;
         this._soundMgr = App.soundMgr;
         this._atlasMgr = App.atlasMgr;
         super();
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
      }
      
      protected function onDispose() : void
      {
         this._atlasMgr.forgetAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this.updateIcon);
         this._scheduler.cancelTask(this.validateState);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._tooltipMgr = null;
         this._scheduler = null;
         this._soundMgr = null;
         this._atlasMgr = null;
         this.icon = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function getNodeBounds(param1:DisplayObject) : Rectangle
      {
         return this.hitArea.getBounds(param1);
      }
      
      public function makeOverState() : void
      {
      }
      
      public function makeUpState() : void
      {
      }
      
      public function setData(param1:ConfiguratorModuleVO) : void
      {
         this._icon = param1.icon;
         this._moduleIntCD = param1.intCD;
         this.active = param1.selected;
         this._atlasMgr.waitForAtlasInit(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this.updateIcon);
      }
      
      public function setIndex(param1:uint, param2:uint) : void
      {
         this._columnIdx = param1;
         this._moduleIdx = param2;
      }
      
      public function get moduleIntCD() : uint
      {
         return this._moduleIntCD;
      }
      
      public function get moduleIdx() : int
      {
         return this._moduleIdx;
      }
      
      public function get columnIdx() : int
      {
         return this._columnIdx;
      }
      
      public function set tooltipEnabled(param1:Boolean) : void
      {
         if(param1 == this._tooltipEnabled)
         {
            return;
         }
         this._tooltipEnabled = param1;
         if(!this._tooltipEnabled)
         {
            this._tooltipMgr.hide();
         }
      }
      
      private function updateIcon() : void
      {
         this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._icon,this.icon.graphics);
      }
      
      private function validateState(param1:Boolean) : void
      {
         this._active = param1;
         this.gotoAndStop(!!this._active ? ACTIVE_FRAME_LABEL : DISABLED_FRAME_LABEL);
      }
      
      private function set active(param1:Boolean) : void
      {
         this._scheduler.cancelTask(this.validateState);
         if(this._active == param1)
         {
            return;
         }
         this._scheduler.scheduleOnNextFrame(this.validateState,param1);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipEnabled)
         {
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BATTLE_ROYALE_MODULES_HANGAR,null,this._moduleIntCD);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._tooltipEnabled)
         {
            this._tooltipMgr.hide();
         }
      }
   }
}
