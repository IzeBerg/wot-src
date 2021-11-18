package net.wg.gui.lobby.profile.pages.formations
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   
   public class FortInfo extends Sprite implements ISpriteEx
   {
      
      private static const LINK_OFFSET:int = 5;
       
      
      public var fortStat0:LineDescrIconText;
      
      public var fortStat1:LineDescrIconText;
      
      public var fortStat2:LineDescrIconText;
      
      public var fortLevel:TextField;
      
      public var fortLinkText:TextField;
      
      public var link:SoundButtonEx;
      
      public function FortInfo()
      {
         super();
         this.fortLinkText.text = PROFILE.SECTION_FORMATIONS_FORT_LINK;
         this.link.tooltip = PROFILE.SECTION_FORMATIONS_TOOLTIP_FORT_LINK;
         App.utils.commons.moveDsiplObjToEndOfText(this.link,this.fortLinkText,LINK_OFFSET);
         this.fortLevel.addEventListener(MouseEvent.MOUSE_OVER,this.onFortLevelMouseOver);
         this.fortLevel.addEventListener(MouseEvent.MOUSE_OUT,this.onFortLevelMouseOut);
      }
      
      public function dispose() : void
      {
         this.fortLevel.removeEventListener(MouseEvent.MOUSE_OVER,this.onFortLevelMouseOver);
         this.fortLevel.removeEventListener(MouseEvent.MOUSE_OUT,this.onFortLevelMouseOut);
         this.fortStat0.dispose();
         this.fortStat0 = null;
         this.fortStat1.dispose();
         this.fortStat1 = null;
         this.fortStat2.dispose();
         this.fortStat2 = null;
         this.fortLevel = null;
         this.fortLinkText = null;
         this.link.dispose();
         this.link = null;
      }
      
      public function update(param1:Object) : void
      {
         this.fortLevel.htmlText = String(param1);
      }
      
      private function onFortLevelMouseOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onFortLevelMouseOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(PROFILE.SECTION_FORMATIONS_TOOLTIP_FORT_LEVEL);
      }
   }
}
