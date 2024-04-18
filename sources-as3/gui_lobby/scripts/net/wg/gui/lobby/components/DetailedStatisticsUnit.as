package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.lobby.components.data.DetailedStatisticsUnitVO;
   import net.wg.gui.lobby.components.events.DashLineTextItemRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class DetailedStatisticsUnit extends UIComponentEx implements IUpdatable
   {
      
      private static const RENDERER_INVALID:String = "rendererInv";
      
      private static const GAP:int = -1;
      
      private static const LABEL_AND_GROUP_GAP:Number = 0;
      
      private static const RENDERER_SIZE_INVALID:String = "rendererSizeInvalid";
       
      
      public var label:TextField = null;
      
      public var group:IGroupEx = null;
      
      private var _data:DetailedStatisticsUnitVO = null;
      
      private var _itemRendererLinkage:String;
      
      public function DetailedStatisticsUnit()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Vertical100PercWidthLayout = null;
         super.configUI();
         if(this.group == null)
         {
            this.group = new GroupEx();
            _loc1_ = new Vertical100PercWidthLayout();
            _loc1_.gap = GAP;
            this.group.layout = _loc1_;
            this.group.addEventListener(Event.RESIZE,this.onGroupResizeHandler,false,0,true);
            this.group.addEventListener(DashLineTextItemRendererEvent.TEXT_SIZE_CHANGED,this.onGroupTextSizeChangedHandler,false,0,true);
            this.addChild(DisplayObject(this.group));
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RENDERER_INVALID))
         {
            this.group.itemRendererLinkage = this._itemRendererLinkage;
         }
         if(isInvalid(RENDERER_SIZE_INVALID))
         {
            this.group.layout.invokeLayout();
            this.group.dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.label.text = this._data.label;
            this.group.dataProvider = this._data.itemsList;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.group.width = _width;
            this.group.invalidateLayout();
         }
         this.group.validateNow();
         _height = this.label.y + this.label.height + LABEL_AND_GROUP_GAP + this.group.height >> 0;
         this.group.y = _height - this.group.height;
      }
      
      override protected function onDispose() : void
      {
         if(this.group)
         {
            this.group.removeEventListener(Event.RESIZE,this.onGroupResizeHandler);
            this.group.removeEventListener(DashLineTextItemRendererEvent.TEXT_SIZE_CHANGED,this.onGroupTextSizeChangedHandler);
            this.group.dispose();
            this.group = null;
         }
         this.label = null;
         this._itemRendererLinkage = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 == this._data)
         {
            return;
         }
         this._data = DetailedStatisticsUnitVO(param1);
         invalidateData();
      }
      
      public function set itemRendererLinkage(param1:String) : void
      {
         if(this._itemRendererLinkage != param1)
         {
            this._itemRendererLinkage = param1;
            invalidate(RENDERER_INVALID);
         }
      }
      
      private function onGroupResizeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.RESIZE,true));
      }
      
      private function onGroupTextSizeChangedHandler(param1:DashLineTextItemRendererEvent) : void
      {
         invalidate(RENDERER_SIZE_INVALID);
      }
   }
}
