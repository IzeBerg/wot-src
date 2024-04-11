package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
   
   public class ResizableContentHeader extends TreeHeader
   {
      
      private static const INVALIDATE_PROGRESS:String = "invProgress";
      
      private static const INVALIDATE_SHOW_DONE:String = "invShowDone";
       
      
      private var _progrType:String = "";
      
      private var _currentProgr:Number = 0;
      
      private var _totalProgr:Number = 0;
      
      private var _progrTooltip:Object = null;
      
      private var _showDone:Boolean = false;
      
      public var progressIndicator:ProgressIndicator;
      
      public var statusMC:QuestStatusComponent;
      
      public function ResizableContentHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressIndicator.visible = false;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         var _loc2_:EventsResizableContentVO = EventsResizableContentVO(param1);
         if(_loc2_.headerProgress)
         {
            this.setProgress(_loc2_.headerProgress);
         }
         this.showDone = _loc2_.showDone;
      }
      
      override protected function onDispose() : void
      {
         this.statusMC.dispose();
         this.statusMC = null;
         this._progrTooltip = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         super.onDispose();
      }
      
      public function setProgress(param1:Object) : void
      {
         var _loc2_:ProgressElementVO = new ProgressElementVO(param1);
         this._progrType = _loc2_.progrBarType;
         this._currentProgr = _loc2_.currentProgrVal;
         this._totalProgr = _loc2_.maxProgrVal;
         this._progrTooltip = _loc2_.progrTooltip;
         invalidate(INVALIDATE_PROGRESS);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_PROGRESS))
         {
            this.progressIndicator.visible = Boolean(this._progrType);
            this.progressIndicator.setValues(this._progrType,this._currentProgr,this._totalProgr);
            this.progressIndicator.setTooltip(this._progrTooltip);
         }
         if(isInvalid(INVALIDATE_SHOW_DONE))
         {
            this.statusMC.visible = this._showDone;
            this.progressIndicator.visible = Boolean(this._progrType) && !this._showDone;
         }
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
         invalidate(INVALIDATE_SHOW_DONE);
      }
   }
}
