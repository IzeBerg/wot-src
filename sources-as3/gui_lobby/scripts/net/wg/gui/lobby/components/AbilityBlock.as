package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.data.AbilityBlockVO;
   import net.wg.infrastructure.base.SimpleDisposable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class AbilityBlock extends SimpleDisposable implements IDisposable
   {
      
      private static const ICON_RIGHT_PADDING:int = 1;
       
      
      public var hit:MovieClip = null;
      
      public var icon:Image = null;
      
      public var abilityTF:TextField = null;
      
      private var _data:AbilityBlockVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function AbilityBlock()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.icon.addEventListener(Event.CHANGE,this.onChangeEventComplete);
         this.icon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ABILITY;
         this.abilityTF.autoSize = TextFieldAutoSize.LEFT;
         this.abilityTF.text = App.utils.locale.makeString(MENU.ABILITY_TITLE);
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.removeMouseListeners();
         this.icon.removeEventListener(Event.CHANGE,this.onChangeEventComplete);
         this.icon.dispose();
         this.icon = null;
         this.hit = null;
         this.abilityTF = null;
         this._tooltipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      public function isAvailable() : Boolean
      {
         return this._data != null;
      }
      
      public function setData(param1:AbilityBlockVO) : void
      {
         this._data = param1;
         if(this._data != null)
         {
            this.addMouseListeners();
         }
         else
         {
            this.removeMouseListeners();
         }
         buttonMode = useHandCursor = this._data != null;
      }
      
      private function addMouseListeners() : void
      {
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeMouseListeners() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function layout() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc1_ = this.icon.width + this.abilityTF.width;
         var _loc2_:int = -(_loc1_ + ICON_RIGHT_PADDING) >> 1;
         _loc3_ = this.abilityTF.height;
         _loc4_ = this.abilityTF.height;
         this.icon.x = _loc2_;
         this.abilityTF.x = _loc2_ + this.icon.width + ICON_RIGHT_PADDING;
         this.abilityTF.y = _loc4_ - _loc3_ >> 1;
         this.hit.x = _loc2_;
         this.hit.height = Math.max(_loc4_,_loc3_);
         this.hit.width = _loc1_;
      }
      
      private function onChangeEventComplete(param1:Event) : void
      {
         this.layout();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         this._tooltipMgr.showWulfTooltip.apply(this._tooltipMgr,[this._data.tooltip].concat(this._data.tooltipArgs));
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
