package net.wg.gui.battle.epicBattle.views.upgradePanel
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.epicBattle.views.upgradePanel.data.EpicConfiguratorModuleVO;
   import net.wg.gui.components.battleRoyale.ModuleConfiguratorEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicConfiguratorRenderer extends UIComponent implements IEpicConfiguratorRenderer
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
       
      
      public var iconLoader:UILoaderAlt = null;
      
      public var hitMc:Sprite = null;
      
      public var level:MovieClip = null;
      
      private var _columnIndex:int = -1;
      
      private var _moduleIndex:int = -1;
      
      private var _moduleIntCD:uint = 0;
      
      private var _mode:String = null;
      
      private var _state:String = "up";
      
      private var _data:EpicConfiguratorModuleVO = null;
      
      public function EpicConfiguratorRenderer()
      {
         super();
         this.hitArea = this.hitMc;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this._moduleIntCD = this._data.intCD;
            if(StringUtils.isNotEmpty(this._data.icon))
            {
               this.iconLoader.source = this._data.icon;
            }
            if(this._data.level > 0)
            {
               this.level.gotoAndStop(this._data.level);
            }
            else
            {
               this.level.visible = false;
            }
            if(this._data.selected)
            {
               this.mode = MODE_ACTIVATED;
            }
            else
            {
               this.mode = !!this._data.available ? MODE_AVAILABLE : MODE_DISABLED;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.hitMc = null;
         this.level = null;
         this._data = null;
         hitArea = null;
         super.onDispose();
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
      
      public function setData(param1:EpicConfiguratorModuleVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setIndex(param1:uint, param2:uint) : void
      {
         this._columnIndex = param1;
         this._moduleIndex = param2;
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
         this.dispatchEvent(new ModuleConfiguratorEvent(ModuleConfiguratorEvent.MODULE_OVER,this._moduleIntCD,this._columnIndex,this._moduleIndex));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.state = STATE_ANIM_UP;
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
   }
}
