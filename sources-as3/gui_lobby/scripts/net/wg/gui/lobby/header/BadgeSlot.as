package net.wg.gui.lobby.header
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BadgeSlot extends SoundButtonEx
   {
       
      
      public var icon:UILoaderAlt = null;
      
      private var _iconSource:String = null;
      
      public function BadgeSlot()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._iconSource) && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._iconSource;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      public function setIconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            invalidateData();
         }
      }
   }
}
