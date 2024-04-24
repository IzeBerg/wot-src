package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class OperationDescription extends Sprite implements IDisposable
   {
      
      private static const DESCR_TF_X:int = 5;
      
      private static const DESCR_TF_X_CURRENT_STATE:int = -15;
       
      
      public var titleTF:TextField = null;
      
      public var descTF:TextField = null;
      
      private var _state:String;
      
      private var _disposed:Boolean = false;
      
      public function OperationDescription()
      {
         super();
         mouseEnabled = mouseChildren = false;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.descTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.titleTF = null;
         this.descTF = null;
      }
      
      public function setState(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            if(this._state == PERSONAL_MISSIONS_ALIASES.OPERATION_UNLOCKED_STATE)
            {
               this.descTF.x = DESCR_TF_X_CURRENT_STATE;
            }
            else
            {
               this.descTF.x = DESCR_TF_X;
            }
         }
      }
      
      public function get title() : String
      {
         return this.titleTF.htmlText;
      }
      
      public function set title(param1:String) : void
      {
         if(param1 != this.titleTF.htmlText)
         {
            this.titleTF.htmlText = param1;
            this.titleTF.visible = StringUtils.isNotEmpty(param1);
         }
      }
      
      public function get description() : String
      {
         return this.descTF.htmlText;
      }
      
      public function set description(param1:String) : void
      {
         if(param1 != this.descTF.htmlText)
         {
            this.descTF.htmlText = param1;
            this.descTF.visible = StringUtils.isNotEmpty(param1);
         }
      }
      
      public function get titleWidth() : int
      {
         return this.titleTF.width;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
