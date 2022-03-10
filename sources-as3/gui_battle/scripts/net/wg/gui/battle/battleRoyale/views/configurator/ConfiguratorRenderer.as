package net.wg.gui.battle.battleRoyale.views.configurator
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.battleRoyale.IConfiguratorRenderer;
   import net.wg.gui.components.battleRoyale.ModuleConfiguratorEvent;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorModuleVO;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.MouseEventEx;
   
   public class ConfiguratorRenderer extends MovieClip implements IConfiguratorRenderer
   {
      
      public static const START_COLUMN_INDEX:int = 0;
      
      private static const MODE_ACTIVATED:String = "activated";
      
      private static const MODE_AVAILABLE:String = "available";
      
      private static const MODE_DISABLED:String = "disabled";
      
      private static const STATE_UP:String = "up";
      
      private static const STATE_OVER:String = "over";
      
      private static const STATE_ANIM_UP:String = "out";
      
      private static const STATE_ANIM_OVER:String = "hover";
      
      private static const STATE_FRAME_LABEL_SEPARATOR:String = "_";
       
      
      public var icon:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      private var _tooltipEnabled:Boolean = true;
      
      private var _baseDisposed:Boolean = false;
      
      private var _columnIndex:int = -1;
      
      private var _moduleIndex:int = -1;
      
      private var _moduleIntCD:uint = 0;
      
      private var _atlasIconName:String = null;
      
      private var _mode:String = null;
      
      private var _state:String = "up";
      
      private var _atlasMgr:IAtlasManager;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ConfiguratorRenderer()
      {
         this._atlasMgr = App.atlasMgr;
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.hitArea = this.hitMc;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandler);
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
      
      public function getNodeBounds(param1:DisplayObject) : Rectangle
      {
         return this.hitArea.getBounds(param1);
      }
      
      public function makeOverState() : void
      {
         this.state = STATE_ANIM_OVER;
      }
      
      public function makeUpState() : void
      {
         this.state = STATE_ANIM_UP;
      }
      
      public function setData(param1:ConfiguratorModuleVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._moduleIntCD = param1.intCD;
         this.iconName = param1.icon;
         if(param1.selected)
         {
            this.mode = MODE_ACTIVATED;
         }
         else
         {
            this.mode = !!param1.available ? MODE_AVAILABLE : MODE_DISABLED;
         }
      }
      
      public function setIndex(param1:uint, param2:uint) : void
      {
         this._columnIndex = param1;
         this._moduleIndex = param2;
      }
      
      protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this._tooltipMgr = null;
         this._atlasMgr = null;
         hitArea = null;
         this.hitMc = null;
         this.icon = null;
      }
      
      private function drawIcon() : void
      {
         this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasIconName,this.icon.graphics);
      }
      
      public function get columnIdx() : int
      {
         return this._columnIndex;
      }
      
      public function get moduleIdx() : int
      {
         return this._moduleIndex;
      }
      
      public function get moduleIntCD() : uint
      {
         return this._moduleIntCD;
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
      
      private function set iconName(param1:String) : void
      {
         if(param1 == this._atlasIconName)
         {
            return;
         }
         this._atlasIconName = param1;
         if(this._atlasIconName)
         {
            this.drawIcon();
         }
         else
         {
            this.icon.graphics.clear();
         }
      }
      
      private function set mode(param1:String) : void
      {
         if(param1 == this._mode)
         {
            return;
         }
         this._mode = param1;
         this.gotoAndStop(this.stateFrameLabel);
         this.buttonMode = this._mode == MODE_AVAILABLE;
      }
      
      private function set state(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         this.gotoAndPlay(this.stateFrameLabel);
         this._state = this._state == STATE_ANIM_OVER ? STATE_OVER : STATE_UP;
      }
      
      private function get stateFrameLabel() : String
      {
         return this._mode + STATE_FRAME_LABEL_SEPARATOR + this._state;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.state = STATE_ANIM_OVER;
         if(this._tooltipEnabled)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BATTLE_ROYALE_MODULES,null,this._moduleIntCD);
         }
         this.dispatchEvent(new ModuleConfiguratorEvent(ModuleConfiguratorEvent.MODULE_OVER,this._moduleIntCD,this._columnIndex,this._moduleIndex));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.state = STATE_ANIM_UP;
         if(this._tooltipEnabled)
         {
            this._tooltipMgr.hide();
         }
         this.dispatchEvent(new ModuleConfiguratorEvent(ModuleConfiguratorEvent.MODULE_OUT,this._moduleIntCD,this._columnIndex,this._moduleIndex));
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = Boolean(_loc2_) ? uint(_loc2_.buttonIdx) : uint(MouseEventEx.LEFT_BUTTON);
         if(_loc3_ != MouseEventEx.LEFT_BUTTON || this._mode != MODE_AVAILABLE)
         {
            return;
         }
         this.dispatchEvent(new ModuleConfiguratorEvent(ModuleConfiguratorEvent.MODULE_CLICK,this._moduleIntCD,this._columnIndex,this._moduleIndex));
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
