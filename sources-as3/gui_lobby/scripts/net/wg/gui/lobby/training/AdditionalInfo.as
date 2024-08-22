package net.wg.gui.lobby.training
{
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.PREBATTLE_ALIASES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AdditionalInfo extends Sprite implements IDisposable
   {
       
      
      public var content:AdditionalInfoContent = null;
      
      private var _contentLayout:uint = 0;
      
      private var _baseDisposed:Boolean = false;
      
      public function AdditionalInfo()
      {
         super();
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function setContentLayout(param1:uint) : void
      {
         this._contentLayout = param1;
         if(this.content)
         {
            this.content.setLayout(this._contentLayout);
         }
      }
      
      public function setType(param1:String) : void
      {
         if(this.content)
         {
            this.clearContent();
         }
         if(param1)
         {
            this.content = App.utils.classFactory.getComponent(this.getContentLinkage(param1),AdditionalInfoContent);
            this.content.setLayout(this._contentLayout);
            addChild(this.content);
         }
      }
      
      protected function onDispose() : void
      {
         if(this.content)
         {
            this.clearContent();
         }
      }
      
      protected function getContentLinkage(param1:String) : String
      {
         if(param1 == PREBATTLE_ALIASES.TRAINING_ADDITIONAL_INFO_COMP7)
         {
            if(this._contentLayout == AdditionalInfoContent.LAYOUT_BIG)
            {
               return Linkages.COMP7_CONDITIONS_ROOM_LINKAGE;
            }
            return Linkages.COMP7_CONDITIONS_SETTINGS_LINKAGE;
         }
         App.utils.asserter.assert(false,param1 + "does not exists!");
         return null;
      }
      
      private function clearContent() : void
      {
         if(contains(this.content))
         {
            removeChild(this.content);
         }
         this.content.dispose();
         this.content = null;
      }
      
      override public function get width() : Number
      {
         if(this.content)
         {
            return this.content.width;
         }
         return super.width;
      }
   }
}
