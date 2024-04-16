package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.personalMissions.data.IconTextRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class IconTextRenderer extends MovieClip implements IDisposable
   {
       
      
      public var labelTf:TextField;
      
      public var icon:UILoaderAlt;
      
      private var _disposed:Boolean = false;
      
      public function IconTextRenderer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.labelTf = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setData(param1:IconTextRendererVO) : void
      {
         this.icon.source = param1.icon;
         this.labelTf.text = param1.label;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
