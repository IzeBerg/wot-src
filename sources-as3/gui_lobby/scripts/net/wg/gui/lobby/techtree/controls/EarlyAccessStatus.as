package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EarlyAccessStatus extends MovieClip implements IDisposable
   {
      
      private static const ALREADY_DISPOSED_MESSAGE:String = "(EarlyAccessStatus) already disposed!";
       
      
      public var icon:Image;
      
      public var labelTF:TextField = null;
      
      protected var _baseDisposed:Boolean = false;
      
      public function EarlyAccessStatus()
      {
         super();
         this.labelTF.autoSize = TextFieldAutoSize.LEFT;
         this.labelTF.text = MENU.RESEARCH_STATUS_EARLYACCESS;
         this.icon.source = RES_ICONS.MAPS_ICONS_EARLY_ACCESS_NATION_TREE_EA_ICON;
      }
      
      protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.labelTF = null;
      }
      
      public final function dispose() : void
      {
         App.utils.asserter.assert(!this._baseDisposed,name + ALREADY_DISPOSED_MESSAGE);
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      override public function get width() : Number
      {
         return this.labelTF.x + this.labelTF.width;
      }
   }
}
