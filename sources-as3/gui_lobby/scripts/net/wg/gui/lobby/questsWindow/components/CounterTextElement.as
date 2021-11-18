package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.achievements.RedCounter;
   import net.wg.gui.lobby.questsWindow.data.CounterTextElementVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class CounterTextElement extends AbstractResizableContent
   {
      
      public static const DEFAULT_WIDTH:int = 270;
       
      
      public var description:QuestsDashlineItem;
      
      public var counter:RedCounter;
      
      public var battlesLeftTF:TextField;
      
      protected var data:CounterTextElementVO = null;
      
      public var statusMC:QuestStatusComponent;
      
      public function CounterTextElement()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.counter.visible = this.battlesLeftTF.visible = false;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.description.dispose();
         this.description = null;
         this.counter.dispose();
         this.counter = null;
         this.statusMC.dispose();
         this.statusMC = null;
         this.battlesLeftTF = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = new CounterTextElementVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.description.visible = true;
            this.counter.visible = this.battlesLeftTF.visible = this.data.counterValue && !this.data.showDone;
            this.counter.text = this.data.counterValue.toString();
            this.description.width = this.data.counterValue || this.data.showDone ? Number(DEFAULT_WIDTH) : Number(availableWidth);
            this.description.label = this.data.label;
            this.description.value = this.data.value;
            this.description.linkID = this.data.linkID;
            this.description.fullLblData = this.data.fullLabel;
            this.description.isNotAvailable = this.data.isNotAvailable;
            this.statusMC.visible = this.data.showDone;
            this.description.validateNow();
            this.battlesLeftTF.text = this.data.counterDescr;
            this.layoutBlocks();
         }
      }
      
      protected function layoutBlocks() : void
      {
         var _loc1_:Number = Boolean(this.data.label) ? Number(Math.round(this.description.height)) : Number(0);
         var _loc2_:Number = !!Boolean(this.data.counterValue > 0) ? Number(Math.round(this.counter.height + this.counter.y)) : Number(0);
         var _loc3_:Number = Math.max(_loc1_,_loc2_);
         setSize(this.width,_loc3_);
         isReadyForLayout = true;
      }
   }
}
