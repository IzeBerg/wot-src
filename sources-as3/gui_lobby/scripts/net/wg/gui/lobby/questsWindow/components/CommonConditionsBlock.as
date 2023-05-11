package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.achievements.RedCounter;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.questsWindow.data.ProgressBlockVO;
   import net.wg.infrastructure.interfaces.ISortable;
   import scaleform.clik.constants.InvalidationType;
   
   public class CommonConditionsBlock extends AbstractResizableContent implements ISortable
   {
      
      public static const TEXT_PADDING:int = 5;
      
      public static const HEADER_PADDING:int = 10;
      
      public static const DEFAULT_WIDTH:int = 250;
      
      private static const VERTICAL_PADDING:int = 3;
       
      
      public var description:TextField;
      
      public var counter:RedCounter;
      
      public var battlesLeftTF:TextField;
      
      public var progressElementsContainer:MovableBlocksContainer;
      
      private var _sortingFunction:Function = null;
      
      protected var data:ProgressBlockVO = null;
      
      public var statusMC:QuestStatusComponent;
      
      public function CommonConditionsBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressElementsContainer.addEventListener(Event.RESIZE,this.onLayoutResizeHandler);
         this.progressElementsContainer.verticalPadding = VERTICAL_PADDING;
         this.progressElementsContainer.bottomPadding = 0;
         this.progressElementsContainer.isNumerated = true;
         this.progressElementsContainer.sortingFunction = this._sortingFunction;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.progressElementsContainer.removeEventListener(Event.RESIZE,this.onLayoutResizeHandler);
         this.progressElementsContainer.dispose();
         this.progressElementsContainer = null;
         this.description = null;
         this.counter.dispose();
         this.counter = null;
         this.battlesLeftTF = null;
         this.statusMC.dispose();
         this.statusMC = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         this._sortingFunction = null;
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.data)
         {
            this.data.dispose();
         }
         this.data = new ProgressBlockVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.description.visible = true;
            this.counter.visible = this.battlesLeftTF.visible = Boolean(this.data.counterValue && !this.data.showDone);
            this.description.width = this.data.counterValue || this.data.showDone ? Number(DEFAULT_WIDTH) : Number(availableWidth);
            this.description.htmlText = this.data.description;
            this.description.height = this.description.textHeight + TEXT_PADDING;
            this.counter.text = this.data.counterValue.toString();
            this.counter.validateNow();
            this.statusMC.visible = this.data.showDone;
            this.progressElementsContainer.isReadyForLayout = false;
            this.progressElementsContainer.setData(this.data.progressElements);
            this.progressElementsContainer.validateNow();
            this.battlesLeftTF.text = this.data.counterDescr;
            this.layoutBlocks();
         }
         super.draw();
      }
      
      protected function layoutBlocks() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = Boolean(this.data.description) ? Number(Math.round(this.description.height + HEADER_PADDING)) : Number(0);
         this.progressElementsContainer.y = _loc1_;
         var _loc2_:Number = Math.round(_loc1_ + this.progressElementsContainer.height);
         setSize(this.width,_loc2_);
         isReadyForLayout = true;
      }
      
      private function onLayoutResizeHandler(param1:Event) : void
      {
         if(this.progressElementsContainer.isReadyForLayout)
         {
            this.layoutBlocks();
            dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
         }
      }
      
      public function get sortingFunction() : Function
      {
         return this._sortingFunction;
      }
      
      public function set sortingFunction(param1:Function) : void
      {
         this._sortingFunction = param1;
      }
   }
}
