package net.wg.gui.lobby.profile.pages.formations
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.profile.pages.formations.data.FormationHeaderVO;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class FormationHeader extends Sprite implements ISpriteEx
   {
      
      private static const LINK_OFFSET:int = 5;
       
      
      public var formationType:TextField;
      
      public var title:TextField;
      
      public var joinDate:TextField;
      
      public var rank:TextField;
      
      public var icon:ClanEmblem;
      
      public var link:SoundButtonEx;
      
      private var _formationId:int;
      
      public function FormationHeader()
      {
         super();
         this.link.addEventListener(ButtonEvent.CLICK,this.onLinkClick);
      }
      
      public function dispose() : void
      {
         this.formationType = null;
         this.title = null;
         this.joinDate = null;
         this.rank = null;
         this.icon.dispose();
         this.icon = null;
         this.link.removeEventListener(ButtonEvent.CLICK,this.onLinkClick);
         this.link.dispose();
         this.link = null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:FormationHeaderVO = FormationHeaderVO(param1);
         this.formationType.text = _loc2_.formationType;
         this.title.text = _loc2_.title;
         this.joinDate.text = _loc2_.joinDate;
         this.rank.text = _loc2_.rank;
         this.link.visible = _loc2_.showLink;
         if(this.link.visible)
         {
            this.link.tooltip = PROFILE.SECTION_FORMATIONS_TOOLTIP_TEAM_LINK;
            App.utils.commons.moveDsiplObjToEndOfText(this.link,this.title,LINK_OFFSET);
         }
         this._formationId = _loc2_.id;
      }
      
      private function onLinkClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new ShowTeamEvent(this._formationId));
      }
   }
}
