package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.CrewSkillsBlockVO;
   import net.wg.gui.events.UILoaderEvent;
   
   public class CrewSkillsBlock extends BaseTooltipBlock
   {
       
      
      public var skillsTF:TextField;
      
      public var crewTF:TextField;
      
      public var imageLoader:UILoaderAlt = null;
      
      private var _data:CrewSkillsBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function CrewSkillsBlock()
      {
         super();
         this.imageLoader.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this._data = new CrewSkillsBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.crewTF = null;
         this.skillsTF = null;
         this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
         this.imageLoader.dispose();
         this.imageLoader = null;
         this._data.dispose();
         this._data = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            App.utils.asserter.assertNotNull(this._data,"_data " + Errors.CANT_NULL);
            this.skillsTF.htmlText = this._data.skillsStr;
            this.crewTF.htmlText = this._data.crewStr;
            this.imageLoader.source = this._data.crewfIconSrc;
            this._isDataApplied = true;
            return true;
         }
         return false;
      }
      
      private function onImageLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateBlock();
      }
   }
}
