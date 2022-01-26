package net.wg.gui.lobby.profile.pages.formations
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ErrorInfo extends Sprite implements IDisposable
   {
      
      private static const LINK_OFFSET:int = 10;
       
      
      public var description:TextField;
      
      public var title:TextField;
      
      public var link:SoundButtonEx;
      
      public function ErrorInfo()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.description = null;
         this.title = null;
         this.link.dispose();
         this.link = null;
      }
      
      public function init(param1:String, param2:String = null) : void
      {
         this.title.text = param1;
         this.description.visible = param2 != null;
         if(this.description.visible)
         {
            this.description.text = param2;
            App.utils.commons.moveDsiplObjToEndOfText(this.link,this.description,LINK_OFFSET);
         }
      }
      
      public function setTextPosY(param1:int) : void
      {
         var _loc2_:int = this.description.y - this.title.y;
         var _loc3_:int = this.link.y - this.description.y;
         this.title.y = param1;
         this.description.y = this.title.y + _loc2_;
         this.link.y = this.description.y + _loc3_;
      }
   }
}
