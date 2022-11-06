package net.wg.gui.lobby.storage.categories
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.carousels.filters.FilterCounter;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseFilterBlock extends UIComponentEx
   {
      
      private static const FILTER_NAME_GAP:int = 4;
       
      
      public var filterTitle:TextField = null;
      
      public var filterTotalTF:TextField = null;
      
      public var filterCounter:FilterCounter;
      
      public var line:MovieClip;
      
      public function BaseFilterBlock()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.filterCounter.setCloseButtonTooltip(TOOLTIPS.STORAGE_FILTERCOUNTER_CLOSEBUTTON);
         this.filterTitle.text = STORAGE.STORAGE_FILTERTITLE;
         this.filterTitle.autoSize = TextFieldAutoSize.LEFT;
         this.filterTotalTF.autoSize = TextFieldAutoSize.LEFT;
         visible = true;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         validateNow();
      }
      
      override protected function onDispose() : void
      {
         this.filterCounter.dispose();
         this.filterCounter = null;
         this.line = null;
         this.filterTotalTF = null;
         this.filterTitle = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.line.width = width;
            _loc1_ = this.filterTitle.x + this.filterTitle.width + FILTER_NAME_GAP;
            this.filterCounter.validateNow();
            this.filterTotalTF.x = _loc1_;
            this.filterCounter.x = _loc1_ - this.filterCounter.countTFContainer.x >> 0;
         }
      }
      
      public function updateCounter(param1:Boolean, param2:String, param3:Boolean) : void
      {
         if(param1)
         {
            this.filterTotalTF.visible = false;
            this.filterCounter.setCount(param2,param3);
            invalidateSize();
            validateNow();
         }
         else
         {
            this.filterTotalTF.htmlText = param2;
            this.filterTotalTF.visible = true;
            this.filterCounter.hide();
         }
      }
      
      protected function get filterNameGap() : int
      {
         return FILTER_NAME_GAP;
      }
   }
}
