package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.data.constants.ProgressIndicatorStates;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import scaleform.clik.constants.InvalidationType;
   
   public class TextProgressElement extends AbstractResizableContent
   {
      
      private static const PADDING:int = 5;
      
      private static const RIGHT_PADDING:int = 55;
      
      private static const DEFAULT_WIDTH:int = 250;
       
      
      public var description:TextField = null;
      
      public var progress:ProgressIndicator = null;
      
      public var indexTF:TextField = null;
      
      public var data:ProgressElementVO = null;
      
      public var statusMC:QuestStatusComponent = null;
      
      public function TextProgressElement()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.data != null)
         {
            this.data.dispose();
         }
         this.data = new ProgressElementVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.description.width = DEFAULT_WIDTH;
         this.indexTF.visible = false;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.description = null;
         this.indexTF = null;
         this.progress.dispose();
         this.progress = null;
         this.statusMC.dispose();
         this.statusMC = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.data != null)
         {
            this.description.htmlText = this.data.description;
            this.statusMC.visible = this.data.showDone;
            if(this.data.progrIndex)
            {
               this.indexTF.text = this.data.progrIndex.toString();
               this.indexTF.visible = true;
               this.description.x = this.indexTF.width ^ 0;
            }
            _loc1_ = this.data.progrBarType;
            _loc2_ = _loc1_ && !this.data.showDone;
            if(_loc2_)
            {
               this.progress.setValues(_loc1_,this.data.currentProgrVal,this.data.maxProgrVal);
               if(_loc1_ == ProgressIndicatorStates.STRATEGIC)
               {
                  _loc3_ = App.utils.locale.makeString(TOOLTIPS.QUESTS_PROGRESS_STRATEGIC);
                  this.progress.setTooltip({"body":_loc3_});
               }
               else if(_loc1_ == ProgressIndicatorStates.CURRENT)
               {
                  _loc3_ = App.utils.locale.makeString(TOOLTIPS.QUESTS_PROGRESS_CURRENT);
                  this.progress.setTooltip({"body":_loc3_});
               }
            }
            else
            {
               this.description.width = availableWidth - this.description.x - RIGHT_PADDING;
            }
            this.progress.visible = _loc2_;
            this.layoutComponents();
         }
      }
      
      private function layoutComponents() : void
      {
         this.description.height = this.description.textHeight + PADDING;
         this.setSize(this.width,this.description.height);
         isReadyForLayout = true;
      }
   }
}
