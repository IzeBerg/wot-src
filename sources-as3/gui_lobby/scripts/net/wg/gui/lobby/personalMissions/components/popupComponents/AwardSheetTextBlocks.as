package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AwardSheetTextBlocks extends MovieClip implements IDisposable
   {
       
      
      public var titleLeftTf:TextField;
      
      public var descrLeftTf:TextField;
      
      public var titleRightTf:TextField;
      
      public var descrRightTf:TextField;
      
      public function AwardSheetTextBlocks()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.titleLeftTf = null;
         this.descrLeftTf = null;
         this.titleRightTf = null;
         this.descrRightTf = null;
         this.onDispose();
      }
      
      public function setData(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.titleLeftTf.text = param1;
         this.descrLeftTf.text = param2;
         this.titleRightTf.text = param3;
         this.descrRightTf.text = param4;
      }
      
      protected function onDispose() : void
      {
      }
   }
}
