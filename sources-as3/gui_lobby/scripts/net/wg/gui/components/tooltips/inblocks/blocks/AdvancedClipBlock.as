package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.tooltips.inblocks.data.ImageBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.controls.UILoader;
   
   public class AdvancedClipBlock extends BaseTooltipBlock
   {
      
      private static const MOVIE_PATH:String = "moviePath ";
       
      
      private var _loader:UILoader;
      
      private var _data:ImageBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function AdvancedClipBlock()
      {
         this._loader = new UILoader();
         super();
         this._loader.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
         this._loader.unload();
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new ImageBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this._loader.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loader.dispose();
         this._loader = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         return false;
      }
      
      private function applyData() : void
      {
         App.utils.asserter.assert(StringUtils.isNotEmpty(this._data.imagePath),MOVIE_PATH + Errors.CANT_EMPTY);
         this._loader.source = this._data.imagePath;
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         addChild(this._loader.content);
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
   }
}
