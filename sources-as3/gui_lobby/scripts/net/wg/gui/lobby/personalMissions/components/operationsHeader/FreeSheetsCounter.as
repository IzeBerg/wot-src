package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class FreeSheetsCounter extends Sprite implements IDisposable
   {
       
      
      public var freeSheetIcon:Image = null;
      
      public var freeSheetCounterTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function FreeSheetsCounter()
      {
         super();
         mouseEnabled = mouseChildren = false;
         this.freeSheetCounterTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.freeSheetIcon.dispose();
         this.freeSheetIcon = null;
         this.freeSheetCounterTF = null;
      }
      
      public function get counterText() : String
      {
         return this.freeSheetCounterTF.htmlText;
      }
      
      public function set counterText(param1:String) : void
      {
         if(param1 != this.freeSheetCounterTF.htmlText)
         {
            this.freeSheetCounterTF.htmlText = param1;
            this.freeSheetCounterTF.visible = StringUtils.isNotEmpty(param1);
         }
      }
      
      public function get iconSource() : String
      {
         return this.freeSheetIcon.source;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(param1 != this.freeSheetIcon.source)
         {
            this.freeSheetIcon.source = param1;
            this.freeSheetIcon.visible = StringUtils.isNotEmpty(param1);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
