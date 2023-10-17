package net.wg.gui.lobby.profile.pages.formations
{
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
   
   public class ClanInfo extends FormationInfoAbstract
   {
       
      
      public var header:FormationHeader;
      
      public var fort:FortInfo;
      
      public var noFort:ErrorInfo;
      
      public function ClanInfo()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.noFort.dispose();
         this.noFort = null;
         this.fort.dispose();
         this.fort = null;
         super.dispose();
      }
      
      override protected function initHeader() : FormationHeader
      {
         return this.header;
      }
      
      override protected function initStatItems() : Vector.<LineDescrIconText>
      {
         return new <LineDescrIconText>[this.fort.fortStat0,this.fort.fortStat1,this.fort.fortStat2];
      }
      
      override protected function onUpdate(param1:ProfileFormationsVO) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         setHeader(param1.clanHeader);
         this.fort.visible = param1.isFortAvailable;
         this.noFort.visible = !param1.isFortAvailable;
         if(param1.isFortAvailable)
         {
            setStats(param1.fortStats);
            this.fort.update(param1.fortLevel);
         }
         else
         {
            this.noFort.link.visible = param1.isClanOwner;
            _loc2_ = !!param1.isPersonalProfile ? PROFILE.SECTION_FORMATIONS_FORT_NONE : PROFILE.SECTION_FORMATIONS_FORT_NONE_THIRDPERSON;
            _loc3_ = !!param1.isClanOwner ? PROFILE.SECTION_FORMATIONS_FORT_NONE : null;
            this.noFort.init(_loc2_,_loc3_);
         }
      }
   }
}
