package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrewSkinNoItemsInfo extends Sprite implements IDisposable
   {
       
      
      private const REASON_INSIDE_HEIGHT_PADDING:int = 4;
      
      public var tfTitle:TextField;
      
      public var tfReason:TextField;
      
      private var _disposed:Boolean = false;
      
      public function CrewSkinNoItemsInfo()
      {
         super();
         this.tfTitle.text = App.utils.locale.makeString(CREW_SKINS.FEATURE_NOCONTENT_HEADER);
      }
      
      public function set reason(param1:String) : void
      {
         this.tfReason.text = App.utils.locale.makeString(param1);
         this.tfReason.height = this.tfReason.textHeight + this.REASON_INSIDE_HEIGHT_PADDING;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.tfTitle = null;
         this.tfReason = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
