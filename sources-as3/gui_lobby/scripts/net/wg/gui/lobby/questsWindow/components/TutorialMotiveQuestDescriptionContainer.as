package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TutorialMotiveQuestDescriptionContainer extends UIComponentEx
   {
      
      private static const LEFT_PADDING:int = 20;
      
      private static const TOP_PADDING:int = 0;
      
      private static const SEPARATOR_PADDING:int = 15;
      
      private static const VERTICAL_PADDING:int = 12;
      
      private static const CONTAINER_EMPTY_HEIGHT:int = 0;
       
      
      public var container:MovableBlocksContainer;
      
      private var _data:Array;
      
      public function TutorialMotiveQuestDescriptionContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.container.x = LEFT_PADDING;
         this.container.y = TOP_PADDING;
         this.container.verticalPadding = VERTICAL_PADDING;
         this.container.bottomPadding = SEPARATOR_PADDING;
         this.container.addEventListener(Event.RESIZE,this.onContainerResizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data != null)
            {
               this.container.isReadyForLayout = false;
               this.container.setData(this._data);
            }
            else
            {
               setSize(this.width,CONTAINER_EMPTY_HEIGHT);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.container.removeEventListener(Event.RESIZE,this.onContainerResizeHandler);
         this.disposeData();
         this.container.dispose();
         this.container = null;
         super.onDispose();
      }
      
      public function setData(param1:Array) : void
      {
         if(param1 != null && param1 != this._data)
         {
            this.disposeData();
            this._data = param1;
            invalidateData();
         }
      }
      
      private function disposeData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._data != null)
         {
            _loc1_ = this._data.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._data[_loc2_] = null;
               _loc2_++;
            }
            this._data.splice(0,_loc1_);
            this._data = null;
         }
      }
      
      private function onContainerResizeHandler(param1:Event) : void
      {
         if(this.container.isReadyForLayout)
         {
            setSize(this.width,actualHeight);
         }
      }
   }
}
