package net.wg.gui.bootcamp.nationsWindow.containers
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.nationsWindow.data.NationItemVO;
   import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class NationButton extends SoundButtonEx implements IScrollerItemRenderer
   {
      
      private static const LOCK_ALPHA:Number = 0.6;
      
      private static const PROMO_SATURATION:Number = 10;
      
      private static const PROMO_OFFSET:int = 3;
       
      
      public var loader:UILoaderAlt = null;
      
      public var selectItem:MovieClip = null;
      
      public var lock:MovieClip = null;
      
      public var slotOverlay:MovieClip = null;
      
      public var disabledOverlay:MovieClip = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _index:uint = 0;
      
      private var _nationItemVO:NationItemVO = null;
      
      public function NationButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         this.selectItem = null;
         this.lock = null;
         this.slotOverlay = null;
         this.disabledOverlay = null;
         this._nationItemVO = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.selectItem.visible = _selected;
            if(this._nationItemVO && this._nationItemVO.isPromo)
            {
               this.disabledOverlay.visible = this.lock.visible = true;
               this.slotOverlay.visible = false;
               this.lock.alpha = !!_selected ? Number(Values.DEFAULT_ALPHA) : Number(LOCK_ALPHA);
               App.utils.commons.setSaturation(this.loader,PROMO_SATURATION);
            }
            else
            {
               this.disabledOverlay.visible = this.lock.visible = false;
               this.slotOverlay.visible = true;
            }
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SELECTED,this._index + PROMO_OFFSET,true));
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setSource(param1:String) : void
      {
         this.loader.source = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         invalidateState();
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 == null || _data == param1)
         {
            return;
         }
         this._nationItemVO = NationItemVO(param1);
         this.setSource(this._nationItemVO.icon);
         label = this._nationItemVO.label;
         invalidateData();
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      public function get rowsCount() : int
      {
         return Values.ZERO;
      }
      
      public function set rowsCount(param1:int) : void
      {
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
   }
}
