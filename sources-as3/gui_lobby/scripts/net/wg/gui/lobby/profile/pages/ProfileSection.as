package net.wg.gui.lobby.profile.pages
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.profile.components.BattlesTypeDropdown;
   import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.infrastructure.base.meta.IProfileSectionMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileSectionMeta;
   
   public class ProfileSection extends ProfileSectionMeta implements IProfileSectionMeta, IResizableContent
   {
      
      private static const DOSSIER_DATA_INVALID:String = "ddInvalid";
      
      private static const ANIMATION_INVALID:String = "animInv";
       
      
      public var layoutManager:SectionLayoutManager = null;
      
      public var battlesDropdown:BattlesTypeDropdown = null;
      
      protected var currentDimension:Point = null;
      
      protected var currentData:Object = null;
      
      protected var battlesType:String = null;
      
      protected var frameLabel:String = null;
      
      private var _centerOffset:int = 0;
      
      private var _isActive:Boolean = false;
      
      private var _isDataInitialized:Boolean = false;
      
      private var _animationManager:SectionsShowAnimationManager = null;
      
      public function ProfileSection()
      {
         super();
         this._animationManager = new SectionsShowAnimationManager(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID) && this.currentDimension)
         {
            this.applyResizing();
         }
         if(isInvalid(DOSSIER_DATA_INVALID) && this.currentData)
         {
            if(!this._isDataInitialized)
            {
               this._isDataInitialized = true;
               invalidate(ANIMATION_INVALID);
            }
            if(this.battlesDropdown)
            {
               this.battlesDropdown.addEventListener(Event.CHANGE,this.onDropDownChangeHandler);
            }
            this.applyData(this.currentData);
         }
         if(isInvalid(ANIMATION_INVALID) && this._isActive && this._isDataInitialized && this._animationManager)
         {
            this._animationManager.play();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.battlesDropdown)
         {
            this.battlesDropdown.addEventListener(Event.CHANGE,this.onDropDownChangeHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         this.currentData = null;
         this.currentDimension = null;
         this._animationManager.dispose();
         this._animationManager = null;
         if(this.battlesDropdown)
         {
            this.battlesDropdown.removeEventListener(Event.CHANGE,this.onDropDownChangeHandler);
            this.battlesDropdown.dispose();
            this.battlesDropdown = null;
         }
         this.disposeLayoutManager();
         super.onDispose();
      }
      
      public function as_responseDossier(param1:String, param2:Object, param3:String, param4:String) : void
      {
         this.currentData = param2;
         this.battlesType = param1;
         this.frameLabel = param3;
         if(this.battlesDropdown)
         {
            this.battlesDropdown.selectedItem = param1;
            this.battlesDropdown.removeEventListener(Event.CHANGE,this.onDropDownChangeHandler);
         }
         invalidate(DOSSIER_DATA_INVALID);
      }
      
      public function as_setInitData(param1:Object) : void
      {
      }
      
      public function as_update(param1:Object) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         if(!this.currentDimension)
         {
            this.currentDimension = new Point();
         }
         this.currentDimension.x = param1;
         this.currentDimension.y = param2;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function applyResizing() : void
      {
         if(this.layoutManager)
         {
            this.layoutManager.setDimension(this.currentDimension.x,this.currentDimension.y);
         }
         this.x = (this.currentDimension.x >> 1) - this._centerOffset;
      }
      
      protected function applyData(param1:Object) : void
      {
      }
      
      protected function disposeLayoutManager() : void
      {
         if(this.layoutManager)
         {
            this.layoutManager.dispose();
            this.layoutManager = null;
         }
      }
      
      public function get active() : Boolean
      {
         return this._isActive;
      }
      
      public function set active(param1:Boolean) : void
      {
         if(this._isActive == param1)
         {
            return;
         }
         this._isActive = param1;
         if(this._isActive)
         {
            invalidate(ANIMATION_INVALID);
         }
         else
         {
            this._animationManager.stop();
         }
         setActiveS(this._isActive);
      }
      
      public function get centerOffset() : int
      {
         return this._centerOffset;
      }
      
      public function set centerOffset(param1:int) : void
      {
         this._centerOffset = param1;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      private function onDropDownChangeHandler(param1:Event) : void
      {
         requestDossierS(this.battlesDropdown.selectedItem);
      }
   }
}
