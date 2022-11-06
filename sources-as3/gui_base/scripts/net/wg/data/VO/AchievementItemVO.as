package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AchievementItemVO extends DAAPIDataClass
   {
      
      private static const FIELD_ICON:String = "icon";
       
      
      public var name:String = "";
      
      public var block:String = "";
      
      public var section:String = "";
      
      public var type:String = "";
      
      public var isInDossier:Boolean = false;
      
      public var localizedValue:String = "0";
      
      public var icon:IconVO = null;
      
      public var value:Number = -1;
      
      public var iconAlpha:Number;
      
      public var dossierType:int;
      
      public var dossierCompDescr:String = "";
      
      public var isRare:Boolean = false;
      
      public var rareIconId:String = "";
      
      public var inactive:Boolean = false;
      
      public var arenaType:int = 1;
      
      public var vehicleLevel:int = 0;
      
      public var rank:int = 0;
      
      public function AchievementItemVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:AchievementItemVO = param1 as AchievementItemVO;
         if(!_loc2_)
         {
            return false;
         }
         if(this.icon is IconVO && _loc2_.icon is IconVO)
         {
            _loc3_ = (this.icon as IconVO).isEquals(_loc2_.icon as IconVO);
         }
         else
         {
            _loc3_ = compare(this.icon,_loc2_.icon);
         }
         return this.name == _loc2_.name && this.block == _loc2_.block && this.section == _loc2_.section && this.type == _loc2_.type && this.isInDossier == _loc2_.isInDossier && this.localizedValue == _loc2_.localizedValue && _loc3_ && this.value == _loc2_.value && this.iconAlpha == _loc2_.iconAlpha && this.dossierType == _loc2_.dossierType && this.dossierCompDescr == _loc2_.dossierCompDescr && this.arenaType == _loc2_.arenaType && this.vehicleLevel == _loc2_.vehicleLevel;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_ICON)
         {
            this.icon = new IconVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         super.onDispose();
      }
   }
}
