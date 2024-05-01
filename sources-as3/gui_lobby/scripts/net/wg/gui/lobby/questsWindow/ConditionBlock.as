package net.wg.gui.lobby.questsWindow
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
   import net.wg.gui.lobby.questsWindow.components.MovableBlocksContainer;
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ConditionBlock extends AbstractResizableContent
   {
      
      private static const LEFT_PADDING:int = 20;
      
      private static const CONTAINER_PADDING:int = 16;
      
      private static const SEPARATOR_PADDING:int = 15;
      
      private static const VERTICAL_PADDING:int = 12;
       
      
      public var topConditions:ResizableContainer;
      
      public var topSeparator:Sprite;
      
      public var lowerSeparator:Sprite;
      
      public var blocksContainer:MovableBlocksContainer;
      
      public var description:DescriptionBlock;
      
      protected var data:RequirementBlockVO = null;
      
      public function ConditionBlock()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this.topConditions.isReadyForLayout = false;
         this.data = RequirementBlockVO(param1);
         this.description.isReadyForLayout = false;
         this.blocksContainer.isReadyForLayout = false;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.topConditions.visible = false;
         this.topConditions.contentAlign = TextFieldAutoSize.RIGHT;
         this.topSeparator.visible = false;
         this.lowerSeparator.visible = false;
         this.topConditions.x = LEFT_PADDING;
         this.topConditions.verticalPadding = VERTICAL_PADDING;
         this.topConditions.bottomPadding = SEPARATOR_PADDING;
         this.topConditions.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.blocksContainer.x = LEFT_PADDING;
         this.blocksContainer.verticalPadding = CONTAINER_PADDING;
         this.blocksContainer.visible = false;
         this.blocksContainer.bottomPadding = CONTAINER_PADDING;
         this.description.visible = false;
         this.blocksContainer.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.blocksContainer.addEventListener(ResizableBlockEvent.VALIDATE_SCROLL_BAR,this.layoutBlocks);
         this.description.addEventListener(Event.RESIZE,this.layoutBlocks);
      }
      
      override protected function onDispose() : void
      {
         this.topConditions.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.topConditions.dispose();
         this.topConditions = null;
         this.topSeparator = null;
         this.lowerSeparator = null;
         this.blocksContainer.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.blocksContainer.removeEventListener(ResizableBlockEvent.VALIDATE_SCROLL_BAR,this.layoutBlocks);
         this.blocksContainer.dispose();
         this.blocksContainer = null;
         this.description.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.description.dispose();
         this.description = null;
         this.data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.description.setLabels(this.data.title,this.data.description);
               this.blocksContainer.setData(this.data.containerElements);
               this.topConditions.setData(this.data.topConditions);
            }
            else
            {
               isReadyForLayout = true;
               setSize(this.width,0);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      private function layoutBlocks(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.blocksContainer.isReadyForLayout && this.description.isReadyForLayout && this.topConditions.isReadyForLayout)
         {
            _loc2_ = this.topConditions.height > 0;
            this.blocksContainer.visible = true;
            this.description.visible = true;
            this.lowerSeparator.visible = this.topSeparator.visible = this.topConditions.visible = _loc2_;
            _loc3_ = Math.round(this.description.y + this.description.height);
            this.topSeparator.y = Math.round(_loc3_);
            this.topConditions.y = Math.round(this.topSeparator.y + SEPARATOR_PADDING);
            this.lowerSeparator.y = Math.round(this.topConditions.y + this.topConditions.height);
            this.blocksContainer.y = _loc3_;
            if(_loc2_)
            {
               _loc5_ = Math.round(this.lowerSeparator.y - this.topSeparator.y);
               this.blocksContainer.y = _loc3_ + _loc5_ + SEPARATOR_PADDING;
            }
            _loc4_ = Math.round(this.blocksContainer.y + this.blocksContainer.height);
            setSize(this.width,_loc4_);
            isReadyForLayout = true;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
   }
}
